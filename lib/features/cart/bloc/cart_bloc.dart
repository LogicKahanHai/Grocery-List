import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:learn_bloc/data/cart_data.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveCartItemEvent>(cartRemoveCartItemEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    if (cart.isEmpty) {
      emit(CartLoadedEmptyState());
      return;
    }
    emit(CartLoadedSuccessState(cartList: cart));
  }
}

FutureOr<void> cartRemoveCartItemEvent(
    CartRemoveCartItemEvent event, Emitter<CartState> emit) async {
  cart.remove(event.productModel);
  emit(CartRemovalSuccessState());
  if (cart.isEmpty) {
    emit(CartLoadedEmptyState());
    return;
  }
  emit(CartLoadedSuccessState(cartList: cart));
}
