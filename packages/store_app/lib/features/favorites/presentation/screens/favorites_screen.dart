import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:proper_store_shared/design_system/sizes/app_sizes.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';

import 'package:proper_store/core/products/presentation/widgets/product_card.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    late final double childAspectRatio;
    late final int crossAxisCount;

    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);

    switch (deviceType) {
      case DeviceType.smallPhone:
        childAspectRatio = 4 / 6;
        crossAxisCount = 1;
        break;
      case DeviceType.mediumPhone:
        childAspectRatio = 4 / 10;
        crossAxisCount = 2;
        break;
      case DeviceType.largePhone:
        childAspectRatio = 3 / 7;
        crossAxisCount = 2;
        break;
      case DeviceType.tablet:
        childAspectRatio = 4 / 7;
        crossAxisCount = 3;
        break;
      case DeviceType.laptop:
        childAspectRatio = 4 / 8;
        crossAxisCount = 4;
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).favoritesTitle)),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listenWhen: (previous, current) =>
            current.failureMessage.isNotEmpty &&
            previous.failureMessage != current.failureMessage,
        listener: (context, state) {
          AppSnackbar.errorSnackbar(
            context: context,
            failureMessage: state.failureMessage,
          );
        },
        builder: (context, state) {
          final screenHeight = MediaQuery.sizeOf(context).height;
          if (state.favoriteProducts.isEmpty) {
            final s = S.of(context);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lottie/wishlist_empty.json",
                    height: screenHeight * .5,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.emptyFavoritesMessage,
                    style: AppTextStyles.bodyDescription,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.home.path),
                    child: Text(s.emptyFavoritesShopNow),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: state.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = state.favoriteProducts[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
