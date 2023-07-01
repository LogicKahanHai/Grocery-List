import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/data/cart_data.dart';
import 'package:learn_bloc/data/grocery_data.dart';
import 'package:learn_bloc/data/wishlist_data.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
    on<HomeWishlistButtonClickedEvent>(homeWishlistButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryList
            .map((e) => ProductModel(
                id: e['id'],
                name: e['name'],
                price: e['price'],
                imageUrl: e['imageUrl'],
                category: e['category']))
            .toList()));
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cart.add(event.productModel);
    emit(HomeItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonClickedEvent(
      HomeWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlist.add(event.productModel);
    emit(HomeItemWishlistedActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }
}
