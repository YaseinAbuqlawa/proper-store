import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/customer_model.dart';

class CustomerCartScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerCartScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return _CustomerCartView(customer: customer);
  }
}

class _CustomerCartView extends StatelessWidget {
  final CustomerModel customer;

  const _CustomerCartView({required this.customer});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: const Color(0x14000000),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.customerCartTitle, style: AppTextStyles.heroHeadline),
            Text(
              customer.name,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: AppColors.textSubtle,
              ),
            ),
          ],
        ),
      ),
      body: customer.cartItems.isEmpty
          ? Center(
              child: Text(
                l.customerCartEmpty,
                style: AppTextStyles.sectionTitle,
              ),
            )
          : _CartItemsGrid(items: customer.cartItems),
    );
  }
}

class _CartItemsGrid extends StatelessWidget {
  final List<CartItemModel> items;

  const _CartItemsGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.large),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisSpacing: AppSpacing.medium,
            crossAxisSpacing: AppSpacing.medium,
            childAspectRatio: 0.80,
          ),
          itemCount: items.length,
          itemBuilder: (_, index) => _CartItemCard(item: items[index]),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        border: Border.all(color: const Color(0x0F000000)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.borderRadiusLarge),
                  ),
                  child: item.imageUrl.isNotEmpty
                      ? Image.network(
                          item.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const _ImagePlaceholder(),
                        )
                      : const _ImagePlaceholder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (item.discountValue > 0) ...[
                      Text(
                        '${item.sellingPrice.toStringAsFixed(0)} ج',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          color: AppColors.textSubtle,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.offerPrice.toStringAsFixed(0)} ج',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.goldMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ] else
                      Text(
                        '${item.sellingPrice.toStringAsFixed(0)} ج',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.goldMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: AppSpacing.small,
            right: AppSpacing.small,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.goldRoyal,
                shape: BoxShape.circle,
              ),
              child: Text(
                '×${item.quantity}',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFF0F0F0),
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textSubtle,
        ),
      ),
    );
  }
}
