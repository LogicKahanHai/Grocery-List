import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/ui/cart.dart';
import 'package:learn_bloc/features/home/bloc/home_bloc.dart';
import 'package:learn_bloc/features/commons/product_tile_widget.dart';
import 'package:learn_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item added to cart'),
            duration: Duration(seconds: 1),
          ));
        } else if (state is HomeItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item added to wishlist'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Rishi\'s Grocery List'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      product: successState.products[index],
                      bloc: homeBloc,
                    );
                  }),
            );

          case HomeLoadedFailureState:
            return const Scaffold(
                body: Center(child: Text('Something went wrong')));

          default:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
