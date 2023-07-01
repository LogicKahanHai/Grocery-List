import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_bloc/data/cart_data.dart';
import 'package:learn_bloc/data/grocery_data.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';

void main() {
  group("Cart BLoC Test", () {
    late CartBloc cartBloc;
    late List<ProductModel> products;
    var local_cart = cart;

    setUp(() {
      cartBloc = CartBloc();
      products = GroceryData.groceryList
          .map((e) => ProductModel(
              id: e['id'],
              name: e['name'],
              price: e['price'],
              imageUrl: e['imageUrl'],
              category: e['category']))
          .toList();
      local_cart = [];
    });
    test("Initial Test", () {
      expect(cartBloc.state, isA<CartInitial>());
    });

    blocTest(
      "Cart Initial Event Empty test",
      build: () => cartBloc,
      act: (bloc) => bloc.add(CartInitialEvent()),
      wait: const Duration(seconds: 1),
      expect: () => [isA<CartLoadingState>(), isA<CartLoadedEmptyState>()],
    );

    blocTest(
      "Cart Initial Event Item Exists Test",
      build: () => cartBloc,
      act: (bloc) {
        cart.addAll(products);
        bloc.add(CartInitialEvent());
      },
      wait: const Duration(seconds: 1),
      expect: () => [isA<CartLoadingState>(), isA<CartLoadedSuccessState>()],
    );

    blocTest(
      "Cart Remove Item Event Test",
      build: () => cartBloc,
      act: (bloc) {
        cart.addAll(products);
        bloc.add(CartRemoveCartItemEvent(productModel: products[0]));
      },
      expect: () =>
          [isA<CartRemovalSuccessState>(), isA<CartLoadedSuccessState>()],
    );

    blocTest(
      "Cart Remove Item Event Empty Test",
      build: () => cartBloc,
      act: (bloc) {
        cart = local_cart;
        cart.add(products[0]);
        bloc.add(CartRemoveCartItemEvent(productModel: products[0]));
      },
      expect: () =>
          [isA<CartRemovalSuccessState>(), isA<CartLoadedEmptyState>()],
    );
  });
}
