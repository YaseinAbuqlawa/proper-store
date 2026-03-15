import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:proper_store/core/router/app_routes.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404',
              style: AppTextStyles.heroHeadline.copyWith(
                fontSize: 72,
                color: AppColors.goldRoyal,
              ),
            ),
            const SizedBox(height: 12),
            Text(S.of(context).notFoundTitle, style: AppTextStyles.sectionTitle),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home.path),
              child: Text(S.of(context).backToHome),
            ),
          ],
        ),
      ),
    );
  }
}
