import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart';

class SignInWithIdentitySection extends StatelessWidget {
  final AuthCubit authCubit;
  final String text;
  const SignInWithIdentitySection({
    super.key,
    required this.text,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: AppColors.textSecondary, thickness: .25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text, style: AppTextStyles.bodyDescription),
            ),

            Expanded(
              child: Divider(color: AppColors.textSecondary, thickness: .25),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _SignInWithIdentityButton(
                onPressed: () async {
                  await authCubit.signInWithGoogle();
                },
                assetName: "assets/icons/google_icon.svg",
                buttonName: "جوجل",
              ),
            ),
            AppSpacer(width: 16),
            Expanded(
              child: _SignInWithIdentityButton(
                onPressed: () async {
                  await authCubit.signInWithFacebook();
                },
                assetName: "assets/icons/facebook_icon.svg",
                buttonName: "فيسبوك",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignInWithIdentityButton extends StatelessWidget {
  final void Function()? onPressed;
  final String assetName;
  final String buttonName;
  const _SignInWithIdentityButton({
    required this.onPressed,
    required this.assetName,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGray,
        shadowColor: AppColors.darkGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assetName, width: 24, height: 24),
          AppSpacer(width: 15),
          Text(
            buttonName,
            style: AppTextStyles.buttonText.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
