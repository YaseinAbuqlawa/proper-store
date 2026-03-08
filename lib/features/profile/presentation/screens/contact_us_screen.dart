import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/generated/l10n.dart';

@JS('window.open')
external void _openWindow(String url, String target);

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const _whatsappNumber = '201019500808';
  static const _phoneNumber = '01019500808';
  static const _facebookUrl = 'https://facebook.com/Proper.fayom';
  static const _instagramUrl = 'https://instagram.com/prope.r7';
  static const _tiktokUrl = 'https://tiktok.com/@properstore';

  void _open(String url) => _openWindow(url, '_blank');

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.contactUs)),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screenPadding,
          children: [
            AppSpacing.verticalSpaceMedium,
            Text(
              'يسعدنا التواصل معك عبر أي من القنوات التالية',
              style: AppTextStyles.bodyDescription,
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSpaceLarge,
            _ContactTile(
              icon: Icons.chat,
              color: const Color(0xFF25D366),
              label: 'واتساب',
              value: '+$_phoneNumber',
              onTap: () => _open('https://wa.me/$_whatsappNumber'),
            ),
            _ContactTile(
              icon: Icons.phone,
              color: AppColors.goldRoyal,
              label: 'اتصال',
              value: _phoneNumber,
              onTap: () => _open('tel:$_phoneNumber'),
            ),
            _ContactTile(
              icon: Icons.people,
              color: const Color(0xFF1877F2),
              label: 'فيسبوك',
              value: 'Proper Store',
              onTap: () => _open(_facebookUrl),
            ),
            _ContactTile(
              icon: Icons.camera_alt,
              color: const Color(0xFFE1306C),
              label: 'انستجرام',
              value: '@prope.r7',
              onTap: () => _open(_instagramUrl),
            ),
            _ContactTile(
              icon: Icons.music_note,
              color: AppColors.whiteColor,
              label: 'تيك توك',
              value: '@properstore',
              onTap: () => _open(_tiktokUrl),
            ),
            AppSpacing.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.medium),
      child: Material(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.medium,
              vertical: AppSpacing.large,
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                AppSpacing.horizontalSpaceMedium,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: AppTextStyles.productName),
                      const SizedBox(height: 2),
                      Text(value, style: AppTextStyles.bodyDescription),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
