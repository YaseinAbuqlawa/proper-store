import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';

class ProfileUserImage extends StatelessWidget {
  final String photoUrl;
  final bool anonymous;
  const ProfileUserImage({
    super.key,
    this.anonymous = false,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: anonymous
            ? _ImageFrame(anonymous: true, child: Icon(Icons.lock))
            : Stack(
                alignment: Alignment.bottomRight,
                children: [
                  _ImageFrame(
                    child: CachedNetworkImage(
                      imageUrl: photoUrl,
                      errorWidget: (_, _, _) => CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 25,
                    height: 25,
                    child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: AppColors.goldRoyal,
                      ),
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.blackDeep,
                        size: AppSizes.iconSizeSmall,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _ImageFrame extends StatelessWidget {
  final Widget child;
  final bool anonymous;
  const _ImageFrame({required this.child, this.anonymous = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(
          color: anonymous ? AppColors.textSubtle : AppColors.goldRoyal,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(50), child: child),
    );
  }
}
