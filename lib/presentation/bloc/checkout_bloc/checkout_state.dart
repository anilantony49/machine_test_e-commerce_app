import 'package:equatable/equatable.dart';
import 'package:machine_test/data/product_model.dart';

abstract class CheckoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final List<ProductModel> items;
  final double subtotal;

  CheckoutLoaded({required this.items, required this.subtotal});

  @override
  List<Object?> get props => [items, subtotal];
}

class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}