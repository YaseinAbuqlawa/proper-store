import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/phone_auth_screen_presentation/cubit/phone_auth_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

class AuthTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? titleRowButton;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool readOnly;
  final IconData icon;
  final String title;
  final String hint;
  const AuthTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.titleRowButton,
    required this.title,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.bodyDescription),
              titleRowButton ?? Container(),
            ],
          ),
          AppSpacer(height: 5),
          TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            maxLength: maxLength,
            validator: validator,
            readOnly: readOnly,
            decoration: _authTextFieldDecoration(
              prefixIcon: prefixIcon,
              hint: hint,
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneAuthTextField extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneAuthTextField({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
      builder: (context, state) {
        final titleRowButton = InkWell(
          onTap: () {
            context.read<PhoneAuthCubit>().backToInitialState();
          },
          child: Text(
            s.changePhoneNumber,
            style: AppTextStyles.buttonText.copyWith(
              color: AppColors.goldRoyal,
            ),
          ),
        );

        return AuthTextField(
          title: s.phoneNumberLabel,
          hint: '×××××××××1',
          icon: Icons.phone,
          prefixIcon: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text(
              "20+",
              style: AppTextStyles.bodyDescription.copyWith(
                color: AppColors.textSecondary.withValues(alpha: 1),
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return s.fieldRequired;
            }
            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
              return s.phoneNumberMustBe10Digits;
            }
            return null;
          },
          titleRowButton: state.maybeWhen(
            otpIssue: (_) => titleRowButton,
            otpLoading: () => titleRowButton,
            otpSent: () => titleRowButton,
            orElse: () => Container(),
          ),
          readOnly: state.maybeWhen(
            otpIssue: (_) => true,
            otpLoading: () => true,
            otpSent: () => true,
            orElse: () => false,
          ),
          maxLength: 10,
          keyboardType: TextInputType.phone,
          controller: phoneController,
        );
      },
    );
  }
}

class OtpAuthTextField extends StatelessWidget {
  const OtpAuthTextField({super.key, required this.otpController});

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
      builder: (context, state) {
        final otpField = AuthTextField(
          title: s.otpCodeLabel,
          hint: '------',
          icon: Icons.check,
          validator: (value) {
            if (value!.length < 6) {
              return s.otpMustBe6Digits;
            }
            return null;
          },
          keyboardType: TextInputType.number,
          maxLength: 6,
          controller: otpController,
        );

        return state.maybeWhen(
          orElse: () => Container(),
          otpSent: () => otpField,
          otpIssue: (_) => otpField,
          otpLoading: () => otpField,
        );
      },
    );
  }
}

InputDecoration _authTextFieldDecoration({
  required String hint,
  required IconData icon,
  Widget? prefixIcon,
}) {
  return InputDecoration(
    fillColor: AppColors.darkGray.withValues(alpha: .75),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
      borderSide: BorderSide.none,
    ),
    suffixIconColor: AppColors.textSecondary.withValues(alpha: .5),
    hint: Text(
      hint,
      style: AppTextStyles.bodyDescription.copyWith(
        color: AppColors.textSecondary.withValues(alpha: .5),
      ),
    ),
    suffixIcon: Icon(icon),
    prefixIcon: prefixIcon,
  );
}
