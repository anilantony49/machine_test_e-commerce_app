part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

// class AddProductToCartEvent extends ProductEvent {
//   final ProductModel product;

//   AddProductToCartEvent(this.product);
// }

// class RemoveProductFromCartEvent extends ProductEvent {
//   final int productId;

//   RemoveProductFromCartEvent(this.productId);
// }