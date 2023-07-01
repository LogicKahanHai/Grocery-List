import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/commons/product_tile_widget.dart';
import 'package:learn_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      listenWhen: (previous, current) => current is WishlistActionState,
      buildWhen: (previous, current) => current is! WishlistActionState,
      listener: (context, state) {
        if (state is WishlistRemovalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item removed from wishlist'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case WishlistLoadingState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          case WishlistLoadedSuccessState:
            final successState = state as WishlistLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Wishlist Items'),
                backgroundColor: Colors.teal,
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      product: successState.products[index],
                      bloc: wishlistBloc);
                },
              ),
            );
          case WishlistLoadedEmptyState:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Wishlist Items'),
                backgroundColor: Colors.teal,
              ),
              body: const Center(
                child: Text('Wishlist is empty'),
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
