import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/sizes/app_sizes.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/product_model.dart';

import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/products/presentation/widgets/product_card.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:proper_store/features/home/presentation/widgets/home_categories_list_view.dart';
import 'package:proper_store/features/home/presentation/widgets/home_main_collection_banner.dart';
import 'package:proper_store/features/products/presentation/models/products_screen_args.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = sl<HomeCubit>()
      ..getMostSoldProducts()
      ..getMainCollectionBannerData()
      ..getBagCategories();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);

    final (double childAspectRatio, int crossAxisCount) = switch (deviceType) {
      DeviceType.smallPhone => (4 / 6, 1),
      DeviceType.mediumPhone => (4 / 10, 2),
      DeviceType.largePhone => (3 / 7, 2),
      DeviceType.tablet => (4 / 7, 3),
      DeviceType.laptop => (4 / 8, 4),
    };

    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _appBar(context),
        body: SafeArea(
          child: Skeleton.keep(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: HomeMainCollectionBanner(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionTitle(title: S.of(context).categories),
                      ),
                      const AppSpacer(height: AppSpacing.small),
                      HomeCategoriesListView(),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SectionTitle(title: S.of(context).mostSoldSectionTitle),
                        GestureDetector(
                          onTap: () => context.push(
                            AppRoutes.products.path,
                            extra: ProductsScreenArgs(
                              title: S.of(context).mostSoldSectionTitle,
                              filter: const ProductFilterAll(),
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

                SliverPadding(
                  padding: EdgeInsets.only(bottom: 30, right: 10, left: 10),
                  sliver:
                      BlocSelector<
                        HomeCubit,
                        HomeState,
                        ({
                          List<ProductModel> products,
                          bool isLoading,
                          bool isFailure,
                        })
                      >(
                        selector: (state) => (
                          products: state.mostSoldProductsList,
                          isLoading: state.productsState == HomeStates.loading,
                          isFailure: state.productsState == HomeStates.failure,
                        ),
                        builder: (context, data) {
                          if (data.isFailure) {
                            return SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      S.of(context).firebase_error_unexpected,
                                    ),
                                    TextButton(
                                      onPressed: () => context
                                          .read<HomeCubit>()
                                          .getMostSoldProducts(),
                                      child: Text(S.of(context).retry),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Show placeholder skeletons while loading
                          final displayList = data.isLoading
                              ? List.filled(6, ProductModel.placeholder())
                              : data.products;

                          if (!data.isLoading && displayList.isEmpty) {
                            return const SliverFillRemaining(
                              child: Center(
                                child: Text('No products available'),
                              ),
                            );
                          }

                          return Skeletonizer.sliver(
                            enabled: data.isLoading,
                            child: SliverGrid.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: childAspectRatio,
                                  ),
                              itemCount: displayList.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: displayList[index],
                                  enableHero: !data.isLoading,
                                );
                              },
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(S.of(context).homeTitle),
    );
  }
}
