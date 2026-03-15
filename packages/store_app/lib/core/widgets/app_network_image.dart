import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double? width;
  final double? height;
  const AppNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.radius = AppSpacing.borderRadiusLarge,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: imageUrl,
          memCacheWidth: 800,
          memCacheHeight: 800,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
