import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class FormMainImageCard extends StatelessWidget {
  final String? existingImageUrl;
  final Uint8List? newImageBytes;
  final VoidCallback onPickImage;

  const FormMainImageCard({
    super.key,
    required this.existingImageUrl,
    required this.newImageBytes,
    required this.onPickImage,
  });

  bool get _hasImage => existingImageUrl != null || newImageBytes != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(),
              _buildOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (newImageBytes != null) {
      return Image.memory(newImageBytes!, fit: BoxFit.cover);
    }
    if (existingImageUrl?.isNotEmpty ?? false) {
      return CachedNetworkImage(
        imageUrl: existingImageUrl!,
        fit: BoxFit.cover,
        errorWidget: (_, _, _) => const _EmptyImagePlaceholder(),
      );
    }
    return const _EmptyImagePlaceholder();
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _hasImage ? Colors.black.withAlpha(50) : Colors.black.withAlpha(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.medium),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(220),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cloud_upload_outlined,
              color: AppColors.darkGray,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            _hasImage
                ? S.of(context).productFormChangeImage
                : S.of(context).productFormPickImage,
            style: AppTextStyles.navLabel.copyWith(
              color: Colors.white,
              shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyImagePlaceholder extends StatelessWidget {
  const _EmptyImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBackground,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.goldMuted,
        ),
      ),
    );
  }
}
