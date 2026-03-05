import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/app_dialog.dart';
import 'package:proper_store/core/helpers/app_snackbar.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/widgets/sign_in_with_identity_section.dart';
import 'package:proper_store/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:proper_store/features/profile/presentation/widgets/profile_user_image.dart';
import 'package:proper_store/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                AppDialog.showLoading(context);
              },
              failure: (failureMessage) {
                if (!context.mounted) return;
                Navigator.pop(context);
                AppSnackbar.errorSnackbar(
                  context: context,
                  failureMessage: failureMessage,
                );
              },
              success: () async {
                if (!context.mounted) return;
                Navigator.pop(context);
                AppSnackbar.successSnackbar(
                  context: context,
                  message: s.loginSuccess,
                );
                await context.read<ProfileCubit>().getCustomerData();
              },
            );
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (failureMessage) {
                if (!context.mounted) return;
                AppSnackbar.errorSnackbar(
                  context: context,
                  failureMessage: failureMessage,
                );
              },
            );
          },
        ),
      ],

      child: Scaffold(
        appBar: AppBar(title: Text(s.profileTitle)),
        body: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => Skeletonizer(
                        enabled: true,
                        child: _CustomerInfo(
                          name: "customer name",
                          email: "example@example.com",
                          photoUrl: "",
                        ),
                      ),
                      loaded: (customer) => _CustomerInfo(
                        name: customer.name,
                        email: customer.email,
                        photoUrl: customer.photoUrl,
                      ),
                      anonymous: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileUserImage(photoUrl: "", anonymous: true),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              s.signInForBestService,
                              style: AppTextStyles.bodyDescription,
                            ),
                          ),
                          SignInWithIdentitySection(
                            text: s.signInEasilyVia,
                            authCubit: context.read<AuthCubit>(),
                          ),
                        ],
                      ),

                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                Column(
                  children: [
                    _ProfileButton(buttonName: s.ordersTitle, onPressed: () {}),
                    Divider(thickness: .05),
                    AppSpacer(height: 10),
                    _ProfileButton(buttonName: s.myAddresses, onPressed: () => context.push(AppRoutes.addresses.path)),
                    Divider(thickness: .05),
                    AppSpacer(height: 10),

                    _ProfileButton(buttonName: s.contactUs, onPressed: () {}),
                    Divider(thickness: .05),
                    AppSpacer(height: 10),

                    _ProfileButton(
                      buttonName: s.returnPolicy,
                      onPressed: () {},
                    ),
                    Divider(thickness: .05),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _SignOutButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomerInfo extends StatelessWidget {
  final String name;
  final String email;
  final String photoUrl;
  const _CustomerInfo({
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileUserImage(photoUrl: photoUrl),
        Text(name, style: AppTextStyles.customerName),
        Text(email, style: AppTextStyles.bodyDescription),
      ],
    );
  }
}

class _SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) {
        return state.maybeWhen(orElse: () => false, anonymous: () => true);
      },
      builder: (context, anonymous) {
        return TextButton(
          onPressed: anonymous
              ? null
              : () async {
                  await context.read<ProfileCubit>().signOut();
                },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.exit_to_app,
                  color: anonymous
                      ? AppColors.textSecondary
                      : AppColors.errorRed,
                ),
              ),
              Text(
                S.of(context).signOut,
                style: AppTextStyles.buttonText.copyWith(
                  color: anonymous
                      ? AppColors.textSecondary
                      : AppColors.errorRed,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  const _ProfileButton({required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) {
        return state.maybeWhen(orElse: () => false, anonymous: () => true);
      },
      builder: (context, anonymous) {
        return TextButton(
          onPressed: anonymous ? null : onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            backgroundColor: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                buttonName,
                style: AppTextStyles.buttonText.copyWith(
                  color: anonymous
                      ? AppColors.textSecondary
                      : AppColors.whiteColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: anonymous
                    ? AppColors.textSecondary
                    : AppColors.goldRoyal,
              ),
            ],
          ),
        );
      },
    );
  }
}
