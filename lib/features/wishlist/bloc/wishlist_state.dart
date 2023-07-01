// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedSuccessState extends WishlistState {
  final List<ProductModel> products;

  WishlistLoadedSuccessState({required this.products});
}

class WishlistLoadedFailureState extends WishlistState {}

class WishlistLoadedEmptyState extends WishlistState {}

class WishlistRemovalSuccessState extends WishlistActionState {}
