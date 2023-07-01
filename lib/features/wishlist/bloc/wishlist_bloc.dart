import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/data/wishlist_data.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveEvent>(wishlistRemoveEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    if (wishlist.isEmpty) {
      emit(WishlistLoadedEmptyState());
      return;
    }
    emit(WishlistLoadedSuccessState(products: wishlist));
  }

  FutureOr<void> wishlistRemoveEvent(
      WishlistRemoveEvent event, Emitter<WishlistState> emit) async {
    wishlist.remove(event.product);
    emit(WishlistRemovalSuccessState());
    if (wishlist.isEmpty) {
      emit(WishlistLoadedEmptyState());
      return;
    }
    emit(WishlistLoadedSuccessState(products: wishlist));
  }
}
