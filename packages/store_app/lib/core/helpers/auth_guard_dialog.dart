import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/widgets/sign_in_with_identity_section.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

/// Shows a dialog prompting anonymous users to sign in before checkout.
///
/// Returns `true` if the user should proceed to checkout (either signed in
/// successfully). Returns `false` if dismissed.
class AuthGuardDialog {
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: const _AuthGuardDialogContent(),
      ),
    );
    return result ?? false;
  }
}

class _AuthGuardDialogContent extends StatelessWidget {
  const _AuthGuardDialogContent();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(success: () => Navigator.of(context).pop(true));
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        final failureMessage = state.maybeWhen(
          failure: (msg) => msg,
          orElse: () => null,
        );

        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Theme.of(context).cardColor,
          title: Text(s.loginToCheckout, style: AppTextStyles.productName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.loginToCheckoutMessage,
                style: AppTextStyles.bodyDescription,
              ),
              if (failureMessage != null) ...[
                AppSpacing.verticalSpaceSmall,
                Text(
                  failureMessage,
                  style: AppTextStyles.bodyDescription.copyWith(
                    color: AppColors.errorRed,
                  ),
                ),
              ],
              AppSpacing.verticalSpaceMedium,
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                SignInWithIdentitySection(
                  text: "سجلي عبر",
                  authCubit: authCubit,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
