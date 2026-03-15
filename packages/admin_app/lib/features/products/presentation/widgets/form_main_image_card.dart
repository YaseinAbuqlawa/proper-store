import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class FormMainImageCard extends StatelessWidget {
  final String? existingImageUrl;
  final Uint8List? newImageBytes;
  final VoidCallback onPickImage;
  final VoidCallback? onRemoveImage;

  const FormMainImageCard({
    super.key,
    required this.existingImageUrl,
    required this.newImageBytes,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  bool get hasImage => existingImageUrl != null || newImageBytes != null;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            if (hasImage) ...[
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: newImageBytes != null
                          ? Image.memory(newImageBytes!, fit: BoxFit.cover)
                          : CachedNetworkImage(
                              imageUrl: existingImageUrl!,
                              fit: BoxFit.cover,
                              errorWidget: (_, _, _) => const Icon(
                                Icons.broken_image_outlined,
                                size: 32,
                              ),
                            ),
                    ),
                  ),
                  if (onRemoveImage != null)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: onRemoveImage,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.errorRed,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
            ],
            OutlinedButton.icon(
              onPressed: onPickImage,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: Text(
                hasImage ? l.productFormChangeImage : l.productFormPickImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
