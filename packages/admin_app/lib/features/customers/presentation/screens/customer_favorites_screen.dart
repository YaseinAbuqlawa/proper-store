import 'package:admin/core/di/injection_container.dart';
import 'package:admin/features/customers/presentation/cubit/customer_favorites_cubit.dart';
import 'package:admin/features/customers/presentation/cubit/customer_favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/customer_model.dart';
import 'package:proper_store_shared/models/product_model.dart';

class CustomerFavoritesScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerFavoritesScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<CustomerFavoritesCubit>()..loadFavorites(customer.favoritesList),
      child: _CustomerFavoritesView(
        customerName: customer.name,
        favoriteIds: customer.favoritesList,
      ),
    );
  }
}

class _CustomerFavoritesView extends StatelessWidget {
  final String customerName;
  final List<String> favoriteIds;

  const _CustomerFavoritesView({
    required this.customerName,
    required this.favoriteIds,
  });

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
            Text(l.customerFavoritesTitle, style: AppTextStyles.heroHeadline),
            Text(
              customerName,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: AppColors.textSubtle,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CustomerFavoritesCubit, CustomerFavoritesState>(
        builder: (context, state) => switch (state) {
          CustomerFavoritesLoading() =>
            const Center(child: CircularProgressIndicator()),
          CustomerFavoritesEmpty() => Center(
            child: Text(
              l.customerFavoritesEmpty,
              style: AppTextStyles.sectionTitle,
            ),
          ),
          CustomerFavoritesFailure(:final message) => _FailureView(
            message: message,
            onRetry: () => context
                .read<CustomerFavoritesCubit>()
                .loadFavorites(favoriteIds),
          ),
          CustomerFavoritesLoaded(:final products) =>
            _ProductsGrid(products: products),
        },
      ),
    );
  }
}

// ── Products Grid ─────────────────────────────────────────────────────────────

class _ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;

  const _ProductsGrid({required this.products});

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
            childAspectRatio: 0.72,
          ),
          itemCount: products.length,
          itemBuilder: (_, index) => _ProductCard(product: products[index]),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        border: Border.all(color: const Color(0x0F000000)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.borderRadiusLarge),
              ),
              child: product.mainImageUrl.isNotEmpty
                  ? Image.network(
                      product.mainImageUrl,
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
                  product.name,
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
                Text(
                  '${product.sellingPrice.toStringAsFixed(0)} ج',
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
        child: Icon(Icons.image_not_supported_outlined, color: AppColors.textSubtle),
      ),
    );
  }
}

// ── Failure View ──────────────────────────────────────────────────────────────

class _FailureView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FailureView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(message, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onRetry,
            child: Text(S.of(context).retryBtn),
          ),
        ],
      ),
    );
  }
}
