import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/commons/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {
        if (state is CartRemovalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item removed from cart'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartLoadingState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          case CartLoadedSuccessState:
            final successState = state as CartLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart Items'),
                backgroundColor: Colors.teal,
              ),
              body: ListView.builder(
                  itemCount: successState.cartList.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      product: successState.cartList[index],
                      bloc: cartBloc,
                    );
                  }),
            );
          case CartLoadedEmptyState:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart Items'),
                backgroundColor: Colors.teal,
              ),
              body: const Center(
                child: Text('Cart is empty'),
              ),
            );
          default:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
