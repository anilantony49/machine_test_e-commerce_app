part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
class CartLoadingState extends CartState {}

class CartLoadSucessState extends CartState {
  final List<ProductModel> cartItems;
  final double totalAmount;

  CartLoadSucessState(this.cartItems, this.totalAmount);
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}
