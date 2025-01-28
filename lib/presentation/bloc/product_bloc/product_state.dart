part of 'product_bloc.dart';

@immutable
sealed class ProductState {
  
}

final class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String errorMessage;

  ProductErrorState(this.errorMessage);
}

class ProductSucessState extends ProductState {
  final List<ProductModel> products;

  ProductSucessState(this.products);
}

class CartUpdatedState extends ProductState {
  final List<ProductModel> cartItems;
  CartUpdatedState(this.cartItems);
}

// class ProductSucessState extends ProductState {}
