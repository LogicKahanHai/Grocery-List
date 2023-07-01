part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeWishlistButtonClickedEvent extends HomeEvent {
  final ProductModel productModel;

  HomeWishlistButtonClickedEvent({required this.productModel});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonClickedEvent extends HomeEvent {
  final ProductModel productModel;

  HomeCartButtonClickedEvent({required this.productModel});
}

class HomeCartButtonNavigateEvent extends HomeEvent {}
