import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_bloc/data/grocery_data.dart';
import 'package:learn_bloc/features/home/bloc/home_bloc.dart';
import 'package:learn_bloc/features/home/models/product_model.dart';

void main() {
  group('Home BLoC Test', () {
    late HomeBloc homeBloc;
    late List<ProductModel> products;

    setUp(() {
      homeBloc = HomeBloc();
      products = GroceryData.groceryList
          .map((e) => ProductModel(
              id: e['id'],
              name: e['name'],
              price: e['price'],
              imageUrl: e['imageUrl'],
              category: e['category']))
          .toList();
    });

    test("Initial Test", () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    blocTest(
      "Home Initial Event test",
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeInitialEvent()),
      wait: const Duration(seconds: 3),
      expect: () => [isA<HomeLoadingState>(), isA<HomeLoadedSuccessState>()],
    );

    blocTest<HomeBloc, HomeState>(
      "Test Add to Cart",
      build: () => homeBloc,
      act: (bloc) =>
          bloc.add(HomeCartButtonClickedEvent(productModel: products[0])),
      expect: () => [isA<HomeItemCartedActionState>()],
    );

    blocTest(
      "Test Add to Wishlist",
      build: () => homeBloc,
      act: (bloc) =>
          bloc.add(HomeWishlistButtonClickedEvent(productModel: products[0])),
      expect: () => [isA<HomeItemWishlistedActionState>()],
    );

    blocTest(
      "Test Navigate to Cart",
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeCartButtonNavigateEvent()),
      expect: () => [isA<HomeNavigateToCartPageActionState>()],
    );

    blocTest(
      "Test Navigate to Wishlist",
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeWishlistButtonNavigateEvent()),
      expect: () => [isA<HomeNavigateToWishlistPageActionState>()],
    );
  });
}
