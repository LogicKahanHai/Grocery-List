part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveCartItemEvent extends CartEvent {
  final ProductModel productModel;

  CartRemoveCartItemEvent({required this.productModel});
}
