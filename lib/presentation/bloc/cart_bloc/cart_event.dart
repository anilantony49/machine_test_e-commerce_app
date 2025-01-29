part of 'cart_bloc.dart';



@immutable
abstract class CartEvent {}

class CartLoad extends CartEvent {}

class CartAdd extends CartEvent {
  final ProductModel item;
  CartAdd(this.item);
}

class CartRemove extends CartEvent {
  final int itemId;
  CartRemove(this.itemId);
}

class CartEdit extends CartEvent {
  final ProductModel item;
  CartEdit(this.item);
}
