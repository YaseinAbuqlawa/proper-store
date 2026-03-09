import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/app_dialog.dart';
import 'package:proper_store/core/helpers/app_snackbar.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';
import 'package:proper_store/features/auth/features/phone_auth_screen_presentation/cubit/phone_auth_cubit.dart';
import 'package:proper_store/features/auth/features/phone_auth_screen_presentation/widgets/auth_text_fields.dart';
import 'package:proper_store/generated/l10n.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController otpController;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => sl<PhoneAuthCubit>(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocListener<PhoneAuthCubit, PhoneAuthState>(
              listener: (context, state) {
                state.whenOrNull(
                  otpLoading: () {
                    if (!context.mounted) return;
                    AppDialog.showLoading(context);
                  },
                  phoneLoading: () {
                    if (!context.mounted) return;
                    AppDialog.showLoading(context);
                  },
                  phoneIssue: (failureMessage) {
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    AppSnackbar.errorSnackbar(
                      context: context,
                      failureMessage: failureMessage,
                    );
                  },
                  otpSent: () {
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    AppSnackbar.successSnackbar(
                      context: context,
                      message: s.otpSentSuccessfully,
                    );
                  },
                  otpIssue: (failureMessage) {
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    AppSnackbar.errorSnackbar(
                      context: context,
                      failureMessage: failureMessage,
                    );
                  },
                );
              },
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.blackGradient,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/proper_logo.png"),
                          Text(
                            s.welcomeMessage,
                            style: AppTextStyles.heroHeadline.copyWith(
                              fontSize: 35,
                            ),
                          ),
                          AppSpacer(height: 5),
                          Text(
                            s.signInToFollowLatestFashion,
                            style: AppTextStyles.bodyDescription,
                          ),

                          AuthTextField(
                            title: s.fullNameLabel,
                            hint: s.enterFullNameHint,
                            icon: Icons.person,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return s.fieldRequired;
                              }
                              if (value.length < 3) {
                                return s.nameMustBeMoreThan2Chars;
                              }
                              return null;
                            },
                          ),
                          PhoneAuthTextField(phoneController: phoneController),
                          OtpAuthTextField(otpController: otpController),
                          _AuthButton(
                            formKey: formKey,
                            phoneController: phoneController,
                            otpController: otpController,
                          ),
                        ],
                      ),
                    ),
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

class _AuthButton extends StatelessWidget {
  const _AuthButton({
    required this.formKey,
    required this.phoneController,
    required this.otpController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              state.maybeWhen(
                orElse: () async => await context
                    .read<PhoneAuthCubit>()
                    .signInWithPhone("+20${phoneController.text}"),
                otpSent: () async => await context
                    .read<PhoneAuthCubit>()
                    .verifyOtp(otpController.text),
                otpIssue: (_) async => await context
                    .read<PhoneAuthCubit>()
                    .verifyOtp(otpController.text),
              );
            }
          },
          child: state.maybeWhen(
            otpLoading: () => Text(s.verifyCode),
            otpSent: () => Text(s.verifyCode),
            otpIssue: (_) => Text(s.verifyCode),
            orElse: () => Text(s.confirmPhoneNumber),
          ),
        );
      },
    );
  }
}
