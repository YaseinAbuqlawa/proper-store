import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/order_model.dart';

import '../../../../core/widgets/confirm_status_update_dialog.dart';
import 'order_status_utils.dart';
import 'status_bottom_sheet.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;
  final VoidCallback onView;
  final Future<void> Function(OrderStatus) onStatusSelected;

  const OrderCard({
    super.key,
    required this.order,
    required this.onView,
    required this.onStatusSelected,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _hovered = false;
  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final date = widget.order.createdAtDate;
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final firstImage = widget.order.products.isNotEmpty
        ? widget.order.products.first.imageUrl
        : null;
    final (statusBg, statusFg) = orderStatusColors(widget.order.status);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.blackDeep.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusSmall,
                  ),
                  child: _Thumbnail(imageUrl: firstImage),
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order.id,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppColors.textSubtle,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.order.shippingAddress.fullName,
                        style: AppTextStyles.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(dateStr, style: AppTextStyles.bodyDescription),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusFull,
                    ),
                  ),
                  child: Text(
                    orderStatusLabel(l, widget.order.status),
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: statusFg,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                if (validNextStatuses(widget.order.status).isNotEmpty) ...[
                  Expanded(
                    child: _CardButton(
                      label: l.updateStatusLabel,
                      backgroundColor: AppColors.goldRoyal,
                      foregroundColor: AppColors.blackDeep,
                      isLoading: _isUpdating,
                      onPressed: _isUpdating
                          ? null
                          : () => _showStatusSheet(context),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.small + 4),
                ],
                Expanded(
                  child: _CardButton(
                    label: l.orderDetails,
                    backgroundColor: AppColors.lightBackground,
                    foregroundColor: AppColors.textPrimary,
                    border: BorderSide(
                      color: AppColors.textSubtle.withValues(alpha: 0.25),
                    ),
                    onPressed: widget.onView,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showStatusSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.borderRadiusLarge),
        ),
      ),
      builder: (_) => StatusBottomSheet(
        currentStatus: widget.order.status,
        onStatusSelected: (s) async {
          Navigator.pop(context);
          if (s == widget.order.status) return;
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => const ConfirmStatusUpdateDialog(),
          );
          if (confirmed != true || !mounted) return;
          setState(() => _isUpdating = true);
          await widget.onStatusSelected(s);
          if (mounted) setState(() => _isUpdating = false);
        },
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? border;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _CardButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    this.border,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border ?? BorderSide.none,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        minimumSize: const Size(0, 44),
      ),
      child: isLoading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor,
              ),
            )
          : Text(label),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String? imageUrl;

  const _Thumbnail({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: 80,
        height: 96,
        fit: BoxFit.cover,
        errorWidget: (_, _, _) => const _PlaceholderThumbnail(),
      );
    }
    return const _PlaceholderThumbnail();
  }
}

class _PlaceholderThumbnail extends StatelessWidget {
  const _PlaceholderThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 96,
      color: AppColors.lightBackground,
      child: const Icon(Icons.image_not_supported, color: AppColors.textSubtle),
    );
  }
}
