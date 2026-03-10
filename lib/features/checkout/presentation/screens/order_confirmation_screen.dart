import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/generated/l10n.dart';
import 'package:web/web.dart' as web;

class OrderConfirmationScreen extends StatefulWidget {
  final String orderId;

  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  bool _showLottie = false;
  JSFunction? _popStateHandler;

  @override
  void initState() {
    super.initState();

    // Defer Lottie load until after the navigation transition completes,
    // preventing the 512 KB JSON parse from causing frame drops.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _showLottie = true);
    });

    if (kIsWeb) {
      // Push a dummy history entry so the first browser-back press stays on
      // this page instead of navigating away.
      web.window.history.pushState(null, '', web.window.location.href);

      // Intercept browser back: push state again to neutralise the pop, then
      // navigate to home — the only valid exit from the confirmation screen.
      _popStateHandler = ((JSAny? _) {
        web.window.history.pushState(null, '', web.window.location.href);
        if (mounted) context.go(AppRoutes.home.path);
      }).toJS;
      web.window.addEventListener('popstate', _popStateHandler);
    }
  }

  @override
  void dispose() {
    if (kIsWeb && _popStateHandler != null) {
      web.window.removeEventListener('popstate', _popStateHandler);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.home.path);
      },
      child: Scaffold(
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
                  RepaintBoundary(
                    child: _showLottie
                        ? Lottie.asset(
                            'assets/lottie/done.json',
                            frameRate: FrameRate(30),
                            repeat: false,
                            width: 200,
                            height: 200,
                          )
                        : const SizedBox(width: 200, height: 200),
                  ),
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
                      color: Theme.of(context).cardColor,
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
                          '#${widget.orderId}',
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
      ),
    );
  }
}
