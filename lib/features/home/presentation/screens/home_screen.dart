import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_spacer.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/product_card.dart';
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:proper_store/features/home/presentation/widgets/home_main_collection_banner.dart';
import 'package:proper_store/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
    return BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..getMostSoldProducts()
        ..getMainCollectionBannerData(),
      child: Scaffold(
        backgroundColor: AppColors.blackCard,
        appBar: _appBar(context),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HomeMainCollectionBanner(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      AppSpacer(height: AppSpacing.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).mostSoldSectionTitle,
                            style: AppTextStyles.sectionTitle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            S.of(context).showAllText,
                            style: AppTextStyles.navLabel.copyWith(
                              color: AppColors.goldRoyal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 30, right: 10, left: 10),
                sliver: BlocSelector<HomeCubit, HomeState, List<ProductModel>>(
                  selector: (state) {
                    return state.mostSoldProductsList;
                  },
                  builder: (context, productsList) {
                    return SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        final product = productsList[index];
                        return ProductCard(
                          imageUrl: product.imageUrls[0],
                          name: product.name,
                          originalPrice: product.sellingPrice,
                          offerPrice: product.offerPrice(),
                          colors: product.colors,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkGray,
      title: Text(S.of(context).homeTitle),
      leading: Padding(
        padding: AppSpacing.cardPadding,
        child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      ),
      shape: BorderDirectional(bottom: BorderSide(color: AppColors.darkGray)),
    );
  }
}
