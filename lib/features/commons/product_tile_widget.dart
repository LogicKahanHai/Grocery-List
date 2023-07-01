// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/home/bloc/home_bloc.dart';

import 'package:learn_bloc/features/home/models/product_model.dart';
import 'package:learn_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel product;
  final Bloc bloc;
  const ProductTileWidget({
    Key? key,
    required this.product,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getIcons() {
      if (bloc.runtimeType == HomeBloc) {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  (bloc as HomeBloc)
                      .add(HomeCartButtonClickedEvent(productModel: product));
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
            IconButton(
                onPressed: () {
                  (bloc as HomeBloc).add(
                      HomeWishlistButtonClickedEvent(productModel: product));
                },
                icon: const Icon(Icons.favorite_border)),
          ],
        );
      } else if (bloc.runtimeType == CartBloc) {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  (bloc as CartBloc)
                      .add(CartRemoveCartItemEvent(productModel: product));
                },
                icon: const Icon(Icons.remove_circle)),
          ],
        );
      } else if (bloc.runtimeType == WishlistBloc) {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  (bloc as WishlistBloc)
                      .add(WishlistRemoveEvent(product: product));
                },
                icon: const Icon(Icons.remove_circle)),
          ],
        );
      } else {
        return const SizedBox();
      }
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            child: Image.network(
              product.imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.category,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  getIcons()
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
