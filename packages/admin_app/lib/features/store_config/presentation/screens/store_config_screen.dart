import 'package:admin/core/di/injection_container.dart';
import 'package:admin/features/store_config/presentation/cubit/store_config_cubit.dart';
import 'package:admin/features/store_config/presentation/widgets/categories_section.dart';
import 'package:admin/features/store_config/presentation/widgets/collection_banner_section.dart';
import 'package:admin/features/store_config/presentation/widgets/shipping_costs_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class StoreConfigScreen extends StatelessWidget {
  const StoreConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StoreConfigCubit>()..loadAll(),
      child: const _StoreConfigView(),
    );
  }
}

class _StoreConfigView extends StatelessWidget {
  const _StoreConfigView();

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      body: BlocBuilder<StoreConfigCubit, StoreConfigState>(
        builder: (context, state) {
          return state.when(
            initial: () => SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.goldRoyal),
            ),
            loaded:
                (
                  shippingCosts,
                  categories,
                  banner,
                  isSavingShipping,
                  isSavingCategory,
                  isSavingBanner,
                ) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.large,
                          AppSpacing.large,
                          AppSpacing.large,
                          AppSpacing.medium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.storeConfigTitle,
                              style: AppTextStyles.heroHeadline,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l.storeConfigSubtitle,
                              style: AppTextStyles.bodyDescription,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(AppSpacing.large),
                      sliver: _buildResponsiveLayout(context),
                    ),
                  ],
                ),
            failure: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.errorRed,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(message, style: AppTextStyles.bodyDescription),
                  const SizedBox(height: AppSpacing.medium),
                  FilledButton(
                    onPressed: () => context.read<StoreConfigCubit>().loadAll(),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.goldRoyal,
                      foregroundColor: AppColors.blackDeep,
                    ),
                    child: Text(l.retryBtn),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 1024;

    if (isWide) {
      return SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  ShippingCostsSection(),
                  SizedBox(height: AppSpacing.large),
                  CategoriesSection(),
                ],
              ),
            ),
            SizedBox(width: AppSpacing.large),
            Expanded(flex: 5, child: CollectionBannerSection()),
          ],
        ),
      );
    }

    return const SliverToBoxAdapter(
      child: Column(
        children: [
          ShippingCostsSection(),
          SizedBox(height: AppSpacing.large),
          CategoriesSection(),
          SizedBox(height: AppSpacing.large),
          CollectionBannerSection(),
          SizedBox(height: AppSpacing.extraLarge),
        ],
      ),
    );
  }
}
