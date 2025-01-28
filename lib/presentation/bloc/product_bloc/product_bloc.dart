import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/domine/repository/repository.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // final ProductRepository productRepository;

  ProductBloc() : super(ProductInitial()) {
    on<FetchProductsEvent>(fetchProductsEvent);
    // on<AddProductToCartEvent>(addProductToCartEvent);
    // on<RemoveProductFromCartEvent>(removeProductFromCartEvent);
  }

  FutureOr<void> fetchProductsEvent(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      // Fetch products from the repository
      final products = await ProductRepository.fetchProducts();
      emit(ProductSucessState(products));
    } catch (e) {
      // Handle errors and emit the error state with the error message
      emit(ProductErrorState(e.toString()));
    }
  }

  
}
