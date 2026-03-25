import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/product_model.dart';
import 'package:proper_store_shared/models/product_variant.dart';

import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/auth_guard_dialog.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/products/presentation/widgets/add_to_favorite.dart';
import 'package:proper_store/core/products/presentation/widgets/product_card.dart';
import 'package:proper_store/core/products/presentation/widgets/product_price.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store/core/widgets/shopping_bag_button.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:proper_store/features/product_details/presentation/widgets/product_details_bottom_nav_bar_buttons.dart';
import 'package:proper_store/features/product_details/presentation/widgets/product_details_images_carousel.dart';
import 'package:proper_store/features/products/presentation/models/products_screen_args.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;
  final String initialImageUrl;
  const ProductDetailsScreen({
    super.key,
    required this.id,
    this.initialImageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => sl<ProductDetailsCubit>()..getProductDetails(id),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).productDetailsScreenTitle),
              actions: const [ShoppingBagButton()],
            ),
            body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => Column(
                    children: [
                      ProductDetailsImagesCarousel(
                        screenHeight: screenHeight,
                        productId: id,
                        imageUrls: [initialImageUrl],
                      ),
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                  success: (productDetails, activeIndex, relatedProductsList) =>
                      CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverToBoxAdapter(
                            child: ProductDetailsImagesCarousel(
                              productId: id,
                              screenHeight: screenHeight,
                              imageUrls:
                                  productDetails!.selectedColor!.imageUrls,
                            ),
                          ),

                          SliverToBoxAdapter(
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: activeIndex,
                                count: productDetails
                                    .selectedColor!
                                    .imageUrls
                                    .length,
                                effect: const WormEffect(
                                  dotWidth: 10,
                                  dotHeight: 10,
                                ),
                              ),
                            ),
                          ),

                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productDetails.name,
                                              style: AppTextStyles
                                                  .productDetailsName,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${productDetails.section} - ${productDetails.category}",
                                              style:
                                                  AppTextStyles.bodyDescription,
                                            ),
                                          ],
                                        ),
                                      ),
                                      AddToFavorite(
                                        productId: productDetails.id,
                                        onPressed: () async {
                                          await context
                                              .read<FavoritesCubit>()
                                              .toggleFavorite(
                                                product: productDetails,
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ProductPrice(
                                    discountPercentage:
                                        productDetails.discountPercentage,
                                    originalPrice: productDetails.sellingPrice,
                                    offerPrice: productDetails.offerPrice,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SliverToBoxAdapter(
                            child: Divider(
                              thickness: .25,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // "اللون المختار: [name]" row
                                  BlocSelector<
                                    ProductDetailsCubit,
                                    ProductDetailsState,
                                    String?
                                  >(
                                    selector: (state) => state.maybeWhen(
                                      orElse: () => null,
                                      success: (p, _, _) =>
                                          (p?.selectedColor ??
                                                  p?.colors.firstOrNull)
                                              ?.name,
                                    ),
                                    builder: (context, colorName) {
                                      return Row(
                                        children: [
                                          Text(
                                            S.of(context).selectedColor,
                                            style: AppTextStyles.sectionTitle,
                                          ),
                                          if (colorName != null) ...[
                                            const SizedBox(width: 8),
                                            Text(
                                              colorName,
                                              style: AppTextStyles
                                                  .bodyDescription
                                                  .copyWith(
                                                    color: AppColors.goldRoyal,
                                                  ),
                                            ),
                                          ],
                                        ],
                                      );
                                    },
                                  ),
                                  const AppSpacer(height: 8),
                                  ColorsRow(
                                    productColors: productDetails.colors,
                                  ),
                                  const SizedBox(height: 16),
                                  SectionTitle(
                                    title: S.of(context).descriptionAndDetails,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    productDetails.description,
                                    style: AppTextStyles.bodyDescription,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (relatedProductsList.isNotEmpty) ...[
                            const SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  thickness: .25,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),

                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SectionTitle(
                                      title: S.of(context).similarProducts,
                                    ),
                                    GestureDetector(
                                      onTap: () => context.push(
                                        AppRoutes.products.path,
                                        extra: ProductsScreenArgs(
                                          title: productDetails.category,
                                          filter: ProductFilterByCategory(
                                            productDetails.category,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        S.of(context).showAllText,
                                        style: AppTextStyles.navLabel.copyWith(
                                          color: AppColors.goldRoyal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SliverToBoxAdapter(
                              child: _RelatedProductsList(
                                relatedProductsList: relatedProductsList,
                              ),
                            ),
                          ],
                        ],
                      ),
                  failure: (code) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S.of(context).firebase_error_unexpected,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyDescription,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => context
                                .read<ProductDetailsCubit>()
                                .getProductDetails(id),
                            child: Text(S.of(context).retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            bottomNavigationBar: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: AddToCartButton(
                      onPressed: () => _addToCart(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: BuyNowButton(onPressed: () => _buyNow(context)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ProductModel? _currentProduct(BuildContext context) {
    return context.read<ProductDetailsCubit>().state.maybeWhen(
      success: (product, _, _) => product,
      orElse: () => null,
    );
  }

  CartItemModel? _buildCartItem(ProductModel product) {
    final productVariant = product.selectedColor ?? product.colors.firstOrNull;
    if (productVariant == null) return null;
    return CartItemModel.fromProductModel(
      product.copyWith(selectedColor: productVariant),
    );
  }

  void _addToCart(BuildContext context) {
    final product = _currentProduct(context);
    if (product == null) return;
    final item = _buildCartItem(product);
    if (item == null) return;
    context.read<CartCubit>().addProductToCart(item);
    AppSnackbar.successSnackbar(
      context: context,
      message: S.of(context).addedToCart,
    );
  }

  Future<void> _buyNow(BuildContext context) async {
    final product = _currentProduct(context);
    if (product == null) return;
    final item = _buildCartItem(product);
    if (item == null) return;

    final isAnonymous = context.read<ProductDetailsCubit>().isUserAnonymous;
    if (isAnonymous) {
      final proceed = await AuthGuardDialog.show(context);
      if (!proceed || !context.mounted) return;
    }
    if (context.mounted) {
      context.push(AppRoutes.checkout.path, extra: [item]);
    }
  }
}

class ColorsRow extends StatelessWidget {
  final List<ProductVariant> productColors;
  const ColorsRow({super.key, required this.productColors});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ProductDetailsCubit,
      ProductDetailsState,
      ProductVariant?
    >(
      selector: (state) {
        return state.maybeWhen(
          orElse: () => null,
          success: (productDetails, activeIndex, relatedProductsList) =>
              productDetails?.selectedColor,
        );
      },
      builder: (context, selectedColor) {
        return Wrap(
          children: List.generate(productColors.length, (index) {
            selectedColor ??= productColors[0];
            final productColor = productColors[index];
            final isSelected = productColor == selectedColor;
            return Tooltip(
              message: productColor.name,
              child: InkWell(
                onTap: () {
                  context.read<ProductDetailsCubit>().selectColor(productColor);
                },
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    boxShadow: [
                      if (isSelected)
                        const BoxShadow(
                          color: AppColors.goldRoyal,
                          blurRadius: 5,
                        ),
                    ],
                    border: isSelected
                        ? Border.all(color: AppColors.goldRoyal)
                        : null,
                    borderRadius: BorderRadius.circular(50),
                    color: productColor.color,
                  ),
                  width: 30,
                  height: 30,
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: productColor.color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _RelatedProductsList extends StatelessWidget {
  final List<ProductModel> relatedProductsList;
  const _RelatedProductsList({required this.relatedProductsList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: relatedProductsList.length,
        itemBuilder: (context, index) {
          final product = relatedProductsList[index];
          return SizedBox(
            width: 200,
            child: ProductCard(
              product: product,
              showAddToCart: false,
              enableHero: false,
            ),
          );
        },
      ),
    );
  }
}
