import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/generated/l10n.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;

  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Lottie.asset("assets/lottie/done.json"),
                AppSpacing.verticalSpaceLarge,
                Text(
                  s.orderConfirmedTitle,
                  style: AppTextStyles.heroHeadline.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpaceSmall,
                Text(
                  s.orderConfirmedMessage,
                  style: AppTextStyles.bodyDescription,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.large,
                    vertical: AppSpacing.small,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusMedium,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${s.orderNumberLabel}: ',
                        style: AppTextStyles.bodyDescription,
                      ),
                      Text(
                        '#$orderId',
                        style: AppTextStyles.productName.copyWith(
                          color: AppColors.goldRoyal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.go(AppRoutes.home.path),
                  child: Text(
                    s.continueShopping,
                    style: AppTextStyles.buttonText,
                  ),
                ),
                AppSpacing.verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
