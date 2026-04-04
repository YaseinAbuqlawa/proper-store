import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = '${usernameController.text.trim()}@properstaff.com';
    context.read<AuthCubit>().signIn(
      email: email,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: _LoginCard(
              formKey: _formKey,
              usernameController: usernameController,
              passwordController: passwordController,
              obscurePassword: obscurePassword,
              onTogglePassword: () =>
                  setState(() => obscurePassword = !obscurePassword),
              onSubmit: _submit,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const _LoginCard({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Logo(),
            const SizedBox(height: 32),
            TextFormField(
              controller: usernameController,
              keyboardType: TextInputType.text,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: s.usernameLabel,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? s.emailValidation : null,
              onFieldSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: s.passwordLabel,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: onTogglePassword,
                ),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? s.passwordValidation : null,
              onFieldSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 8),
            const _ErrorMessage(),
            const SizedBox(height: 24),
            _SubmitButton(onSubmit: onSubmit),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.goldRoyal,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.store, color: AppColors.darkGray, size: 36),
        ),
        const SizedBox(height: 16),
        Text(S.of(context).dashboardTitle, style: AppTextStyles.heroHeadline),
        const SizedBox(height: 4),
        const Text('Proper Store Admin', style: AppTextStyles.sectionTitle),
      ],
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, ServerFailure?>(
      selector: (state) =>
          state.whenOrNull(failure: (failure) => failure),
      builder: (context, failure) {
        if (failure == null) return const SizedBox.shrink();
        final message = failure.fromException(context: context);
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.lightRed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyles.bodyDescription.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const _SubmitButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, bool>(
      selector: (state) =>
          state.maybeWhen(loading: () => true, orElse: () => false),
      builder: (context, isLoading) {
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.darkGray,
                    ),
                  )
                : Text(
                    S.of(context).loginButton,
                    style: AppTextStyles.buttonText,
                  ),
          ),
        );
      },
    );
  }
}
