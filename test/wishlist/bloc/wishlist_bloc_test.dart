import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_bloc/data/grocery_data.dart';
import 'package:learn_bloc/data/wishlist_data.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';
import 'package:learn_bloc/features/wishlist/bloc/wishlist_bloc.dart';

void main() {
  late WishlistBloc wishlistBloc;
  late List<ProductModel> products;

  group('WishlistBloc', () {
    setUp(() {
      wishlistBloc = WishlistBloc();
      products = GroceryData.groceryList
          .map((e) => ProductModel(
              id: e['id'],
              name: e['name'],
              price: e['price'],
              imageUrl: e['imageUrl'],
              category: e['category']))
          .toList();
    });

    tearDown(() {
      wishlist = [];
    });

    test('initial state is correct', () {
      expect(wishlistBloc.state, isA<WishlistInitial>());
    });

    blocTest(
      "Test Initial Event Wishlist",
      build: () => wishlistBloc,
      act: (bloc) => bloc.add(WishlistInitialEvent()),
      wait: const Duration(seconds: 1),
      expect: () =>
          [isA<WishlistLoadingState>(), isA<WishlistLoadedEmptyState>()],
    );

    blocTest(
      "Test Initial Event Item Exists Wishlist",
      build: () => wishlistBloc,
      act: (bloc) {
        wishlist.add(products[0]);
        bloc.add(WishlistInitialEvent());
      },
      wait: const Duration(seconds: 1),
      expect: () =>
          [isA<WishlistLoadingState>(), isA<WishlistLoadedSuccessState>()],
    );

    blocTest(
      "Test Wishlist Remove Item",
      build: () => wishlistBloc,
      act: (bloc) {
        wishlist.addAll(products);
        bloc.add(WishlistRemoveEvent(product: products[0]));
      },
      expect: () => [
        isA<WishlistRemovalSuccessState>(),
        isA<WishlistLoadedSuccessState>()
      ],
    );

    blocTest(
      "Test Wishlist Remove Item Empty List",
      build: () => wishlistBloc,
      act: (bloc) {
        wishlist.add(products[0]);
        bloc.add(WishlistRemoveEvent(product: products[0]));
      },
      expect: () =>
          [isA<WishlistRemovalSuccessState>(), isA<WishlistLoadedEmptyState>()],
    );
  });
}
