import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/app_badge_card.dart';
import 'package:proper_store/core/widgets/app_network_image.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/home/data/models/home_collection_banner_model.dart';
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:proper_store/features/products/presentation/models/products_screen_args.dart';
import 'package:proper_store/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeMainCollectionBanner extends StatelessWidget {
  const HomeMainCollectionBanner({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final DeviceType deviceType = AppSizes.getDeviceType(screenWidth);
        double? titleFontSize;
        double? descriptionFontSize;
        EdgeInsets? buttonPadding;

        if (deviceType == DeviceType.smallPhone ||
            deviceType == DeviceType.mediumPhone) {
          titleFontSize = 16;
          descriptionFontSize = 10;
          buttonPadding = const EdgeInsets.all(5);
        } else {
          buttonPadding = const EdgeInsets.all(12);
        }

        return Skeletonizer(
          enabled: state.bannerState != HomeStates.success,
          child: _BannerData(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            titleFontSize: titleFontSize,
            descriptionFontSize: descriptionFontSize,
            buttonPadding: buttonPadding,
            bannerModel: state.homeCollectionBannerModel,
          ),
        );
      },
    );
  }
}

class _BannerData extends StatelessWidget {
  const _BannerData({
    required this.screenHeight,
    required this.screenWidth,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.buttonPadding,
    required this.bannerModel,
  });

  final HomeCollectionBannerModel bannerModel;
  final double screenHeight;
  final double screenWidth;
  final double? titleFontSize;
  final double? descriptionFontSize;
  final EdgeInsets? buttonPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: screenHeight * .5, minHeight: 250),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: AppNetworkImage(imageUrl: bannerModel.imageUrl),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(180)],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadgeCard(
                    screenWidth: screenWidth,
                    text: bannerModel.badgeText,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    bannerModel.title,
                    style: AppTextStyles.heroHeadline.copyWith(
                      fontSize: titleFontSize,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bannerModel.description,
                    style: AppTextStyles.bodyDescription.copyWith(
                      fontSize: descriptionFontSize,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final collection = bannerModel.collection;
                      context.push(
                        AppRoutes.products.path,
                        extra: ProductsScreenArgs(
                          title: collection ??
                              S.of(context).mainCollectionBannerButtonText,
                          filter: collection != null
                              ? ProductFilterByCollection(collection)
                              : const ProductFilterAll(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: buttonPadding,
                      backgroundColor: AppColors.goldRoyal,
                      foregroundColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, size: 18),
                        const AppSpacer(width: 8),
                        Text(
                          S.of(context).mainCollectionBannerButtonText,
                          style: AppTextStyles.buttonText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
