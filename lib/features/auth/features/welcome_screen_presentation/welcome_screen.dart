import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/theme/app_theme.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/app_dialog.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/widgets/sign_in_with_identity_section.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/widgets/store_logo.dart';
import 'package:proper_store/generated/l10n.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _initialized = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    try {
      await Future.wait([
        precacheImage(AssetImage("assets/images/proper_logo.webp"), context),
        precacheImage(
          AssetImage("assets/images/welcome_page_background.webp"),
          context,
        ),
      ]);
    } finally {
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final screenWidth = MediaQuery.widthOf(context);
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => AppDialog.showLoading(context),
            failure: (failureMessage) {
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          );
        },
        child: Builder(
          builder: (context) {
            final authCubit = context.read<AuthCubit>();
            return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/welcome_page_background.webp",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StoreLogo(),
                    Theme(
                      data: AppTheme.dark(),
                      child: Container(
                      padding: EdgeInsets.all(screenWidth * .04),
                      decoration: BoxDecoration(
                        gradient: AppColors.blackGradient,
                      ),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: AppTextStyles.heroHeadline.copyWith(
                                color: AppColors.whiteColor,
                              ),
                              children: [
                                TextSpan(text: "${s.highQuality}\n"),
                                TextSpan(
                                  text: s.pricesSuitYou,
                                  style: AppTextStyles.heroHeadline.copyWith(
                                    color: AppColors.goldRoyal,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            s.discoverLatestFashion,
                            style: AppTextStyles.bodyDescription.copyWith(
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          _SignInAnonymouslyButton(authCubit: authCubit),
                          SignInWithIdentitySection(
                            text: s.orSignInEasily,
                            authCubit: authCubit,
                          ),
                        ],
                      ),
                    ),
                    ), // Theme
                  ],
                ),
              ),
            ),
            );
          },
        ),
      ),
    );
  }
}

class _SignInAnonymouslyButton extends StatelessWidget {
  const _SignInAnonymouslyButton({required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          AppDialog.showLoading(context);
          await authCubit.signInAnonymously();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).shopAsGuest, style: AppTextStyles.buttonText),
            AppSpacer(width: 20),
            Icon(Icons.arrow_forward, size: AppSizes.iconSizeLarge),
          ],
        ),
      ),
    );
  }
}
