part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeLoadedFailureState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeItemWishlistedActionState extends HomeActionState {}

class HomeItemCartedActionState extends HomeActionState {}

class HomeInitial extends HomeState {}
