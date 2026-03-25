import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/core/widgets/confirm_delete_dialog.dart';
import 'package:admin/features/store_config/presentation/cubit/store_config_cubit.dart';
import 'package:admin/features/store_config/presentation/widgets/add_edit_shipping_dialog.dart';
import 'package:admin/features/products/presentation/widgets/form_section_header.dart';

class ShippingCostsSection extends StatelessWidget {
  const ShippingCostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocBuilder<StoreConfigCubit, StoreConfigState>(
      buildWhen: (prev, curr) {
        if (curr is! StoreConfigLoaded || prev is! StoreConfigLoaded) {
          return true;
        }
        return prev.shippingCosts != curr.shippingCosts ||
            prev.isSavingShipping != curr.isSavingShipping;
      },
      builder: (context, state) {
        if (state is! StoreConfigLoaded) return const SizedBox.shrink();
        final costs = state.shippingCosts;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.large),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            border: Border.all(color: Colors.black.withAlpha(15)),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormSectionHeader(
                      icon: Icons.local_shipping_outlined,
                      title: l.shippingSectionTitle,
                    ),
                  ),
                  _AddButton(
                    label: l.addGovernorate,
                    isSaving: state.isSavingShipping,
                    alreadyAdded: costs.keys.toSet(),
                  ),
                ],
              ),
              AppSpacing.verticalSpaceMedium,
              if (costs.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.medium,
                  ),
                  child: Center(
                    child: Text(
                      l.shippingCostsEmpty,
                      style: AppTextStyles.bodyDescription,
                    ),
                  ),
                )
              else
                ...costs.entries.map(
                  (e) => _GovernorateRow(
                    governorate: e.key,
                    cost: e.value,
                    isSaving: state.isSavingShipping,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final String label;
  final bool isSaving;
  final Set<String> alreadyAdded;

  const _AddButton({
    required this.label,
    required this.isSaving,
    required this.alreadyAdded,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: isSaving
          ? null
          : () => showDialog(
                context: context,
                builder: (_) => AddEditShippingDialog(
                  alreadyAdded: alreadyAdded,
                  onSave: (gov, cost) =>
                      context.read<StoreConfigCubit>().addShippingCost(
                            gov,
                            cost,
                          ),
                ),
              ),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.goldRoyal,
        foregroundColor: AppColors.blackDeep,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
      ),
      icon: const Icon(Icons.add, size: 18),
      label: Text(label, style: AppTextStyles.buttonText.copyWith(fontSize: 13)),
    );
  }
}

class _GovernorateRow extends StatelessWidget {
  final String governorate;
  final double cost;
  final bool isSaving;

  const _GovernorateRow({
    required this.governorate,
    required this.cost,
    required this.isSaving,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
        border: Border(
          right: BorderSide(color: AppColors.goldRoyal.withAlpha(80), width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(governorate, style: AppTextStyles.productName),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cost.toStringAsFixed(0),
                style: AppTextStyles.priceNow.copyWith(fontSize: 15),
              ),
              const SizedBox(width: 4),
              Text(
                'ج.م',
                style: AppTextStyles.bodyDescription.copyWith(fontSize: 11),
              ),
              const SizedBox(width: AppSpacing.medium),
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: AppColors.textSubtle,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: isSaving
                    ? null
                    : () => showDialog(
                          context: context,
                          builder: (_) => AddEditShippingDialog(
                            existingGovernorate: governorate,
                            existingCost: cost,
                            alreadyAdded: const {},
                            onSave: (gov, c) => context
                                .read<StoreConfigCubit>()
                                .addShippingCost(gov, c),
                          ),
                        ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppColors.errorRed,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: isSaving
                    ? null
                    : () => showDialog(
                          context: context,
                          builder: (_) => ConfirmDeleteDialog(
                            message: l.confirmDeleteGovernorate,
                            onConfirm: () => context
                                .read<StoreConfigCubit>()
                                .deleteShippingCost(governorate),
                          ),
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
