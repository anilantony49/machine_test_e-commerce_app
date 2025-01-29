import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:machine_test/presentation/bloc/checkout_bloc/checkout_state.dart';

part 'checkout_event.dart';
// part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final double tax = 2.96;
  final double roundOff = 0.04;

  CheckoutBloc() : super(CheckoutInitial()) {
    on<FetchItemsEvent>(_onFetchItems);
  }

  Future<void> _onFetchItems(
      FetchItemsEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());

    try {
      List<ProductModel> items = [];
      if (event.product != null) {
        items = [event.product!];
      } else {
        items = await CartDb.singleton.getCart();
      }

      double subtotal = items.fold(0.0, (sum, item) {
        double price = item.price;
        int quantity = item.quantity ?? 1;
        return sum + (price * quantity);
      });

      emit(CheckoutLoaded(items: items, subtotal: subtotal));
    } catch (e) {
      emit(CheckoutError("Failed to fetch items: ${e.toString()}"));
    }
  }
}