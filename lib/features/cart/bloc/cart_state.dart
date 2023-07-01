part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<ProductModel> cartList;

  CartLoadedSuccessState({required this.cartList});
}

class CartLoadedFailureState extends CartState {}

class CartLoadedEmptyState extends CartState {}

class CartRemoveCartItemActionState extends CartActionState {
  final ProductModel productModel;

  CartRemoveCartItemActionState({required this.productModel});
}

class CartRemovalSuccessState extends CartActionState {}

class CartInitial extends CartState {}
