part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchItemsEvent extends CheckoutEvent {
  final ProductModel? product;

  FetchItemsEvent(this.product);

  @override
  List<Object?> get props => [product];
}