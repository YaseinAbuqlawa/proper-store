import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/app_dialog.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/welcome_screen_cubit.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/widgets/store_logo.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Future<void> didChangeDependencies() async {
    try {
      await Future.wait([
        precacheImage(AssetImage("assets/images/proper_logo.webp"), context),
        precacheImage(
          AssetImage("assets/images/welcome_page_background.png"),
          context,
        ),
      ]);
    } finally {
      FlutterNativeSplash.remove();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    return BlocProvider(
      create: (context) => sl<WelcomeScreenCubit>(),
      child: Builder(
        builder: (context) {
          final welcomeScreenCubit = context.read<WelcomeScreenCubit>();
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/welcome_page_background.png",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StoreLogo(),
                    Container(
                      padding: EdgeInsets.all(screenWidth * .04),
                      decoration: BoxDecoration(
                        gradient: AppColors.blackGradient,
                      ),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: AppTextStyles.heroHeadline,
                              children: [
                                TextSpan(text: "جودة عالية\n"),
                                TextSpan(
                                  text: "بأسعار تناسبك",
                                  style: AppTextStyles.heroHeadline.copyWith(
                                    color: AppColors.goldRoyal,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "اكتشفي أحدث صيحات الموضة من الأحذية والحقائب في مصر بجودة عالمية.",
                            style: AppTextStyles.bodyDescription,
                            textAlign: TextAlign.center,
                          ),
                          _SignInAnonymouslyButton(
                            welcomeScreenCubit: welcomeScreenCubit,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.textSecondary,
                                  thickness: .25,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "او سجلي الدخول بسهولة",
                                  style: AppTextStyles.bodyDescription,
                                ),
                              ),

                              Expanded(
                                child: Divider(
                                  color: AppColors.textSecondary,
                                  thickness: .25,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _SignInWithIdentityButton(
                                  welcomeScreenCubit: welcomeScreenCubit,
                                  onPressed: () async {
                                    await welcomeScreenCubit.signInWithGoogle();
                                  },
                                  assetName: "assets/icons/google_icon.svg",
                                  buttonName: "جوجل",
                                ),
                              ),
                              AppSpacer(width: 16),
                              Expanded(
                                child: _SignInWithIdentityButton(
                                  welcomeScreenCubit: welcomeScreenCubit,
                                  onPressed: () async {
                                    await welcomeScreenCubit
                                        .signInWithFacebook();
                                  },
                                  assetName: "assets/icons/facebook_icon.svg",
                                  buttonName: "فيسبوك",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SignInWithIdentityButton extends StatelessWidget {
  final void Function()? onPressed;
  final String assetName;
  final String buttonName;
  const _SignInWithIdentityButton({
    required this.welcomeScreenCubit,
    required this.onPressed,
    required this.assetName,
    required this.buttonName,
  });

  final WelcomeScreenCubit welcomeScreenCubit;

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

class _SignInAnonymouslyButton extends StatelessWidget {
  const _SignInAnonymouslyButton({required this.welcomeScreenCubit});

  final WelcomeScreenCubit welcomeScreenCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          AppDialog.showLoading(context);
          await welcomeScreenCubit.signInAnonymously();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("التسوق كزائرة", style: AppTextStyles.buttonText),
            AppSpacer(width: 20),
            Icon(Icons.arrow_forward, size: AppSizes.iconSizeLarge),
          ],
        ),
      ),
    );
  }
}
