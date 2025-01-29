import 'package:bloc/bloc.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is CartLoad) {
        await _loadCart(emit);
      } else if (event is CartAdd) {
        await _addItemToCart(event.item, emit);
      } else if (event is CartRemove) {
        await _removeItemFromCart(event.itemId, emit);
      } else if (event is CartEdit) {
        await _editItemInCart(event.item, emit);
      }
    });
  }

  Future<void> _loadCart(Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      final cartItems = await CartDb().getCart();
      double totalAmount = _calculateTotal(cartItems);
      emit(CartLoadSucessState(cartItems, totalAmount));
    } catch (e) {
      emit(CartErrorState('Failed to load cart.'));
    }
  }

  Future<void> _addItemToCart(
      ProductModel item, Emitter<CartState> emit) async {
    await CartDb().addCart(item);
    await _loadCart(emit);
  }

  Future<void> _removeItemFromCart(int itemId, Emitter<CartState> emit) async {
    await CartDb().removeCart(itemId);
    await _loadCart(emit);
  }

  Future<void> _editItemInCart(
      ProductModel item, Emitter<CartState> emit) async {
    await CartDb().editCart(item, item.id);
    await _loadCart(emit);
  }

  double _calculateTotal(List<ProductModel> cartItems) {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item.price * (item.quantity ?? 1));
    });
  }
}
