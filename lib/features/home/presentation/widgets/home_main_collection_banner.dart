import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/app_badge_card.dart';
import 'package:proper_store/core/widgets/app_network_image.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:proper_store/features/home/presentation/widgets/offer_end_time_counter.dart';
import 'package:proper_store/generated/l10n.dart';

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
          buttonPadding = EdgeInsets.all(0);
        }
        return switch (state.bannerState) {
          HomeStates.success => Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: screenHeight * .5,
                    minHeight: 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusLarge,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AppNetworkImage(
                        imageUrl: state.homeCollectionBannerModel!.imageUrl,
                      ),

                      IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppBadgeCard(
                                screenWidth: screenWidth,
                                text:
                                    state.homeCollectionBannerModel!.badgeText,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Text(
                                  state.homeCollectionBannerModel!.title,
                                  style: AppTextStyles.heroHeadline.copyWith(
                                    fontSize: titleFontSize,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  state.homeCollectionBannerModel!.description,
                                  style: AppTextStyles.bodyDescription.copyWith(
                                    fontSize: descriptionFontSize,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: buttonPadding,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back),
                                    AppSpacer(width: 10),
                                    Text(
                                      S
                                          .of(context)
                                          .mainCollectionBannerButtonText,
                                    ),
                                  ],
                                ),
                              ),
                              AppSpacer(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacer(height: AppSpacing.large),
              OfferEndTimeCounter(
                endDate: state.homeCollectionBannerModel!.endDate,
              ),
            ],
          ),
          _ => Center(child: CircularProgressIndicator()),
        };
      },
    );
  }
}
