import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      elevation: 4,
      shadowColor: AppColors.goldRoyal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        side: BorderSide(color: AppColors.goldMuted),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, color: AppColors.goldRoyal),
            AppSpacing.horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(address.label, style: AppTextStyles.productName),
                      if (address.isDefault) ...[
                        AppSpacing.horizontalSpaceSmall,
                        _DefaultBadge(label: s.defaultBadge),
                      ],
                    ],
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Text(
                    '${address.street}، ${address.buildingNumber}، ${address.area}، ${address.city}',
                    style: AppTextStyles.bodyDescription,
                  ),
                  Text(address.fullName, style: AppTextStyles.bodyDescription),
                  Text(address.phone, style: AppTextStyles.bodyDescription),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.errorRed),
              onPressed: () => _confirmDelete(context, s),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, S s) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(s.delete, style: AppTextStyles.productName),
        content: Text(s.deleteAddressConfirm, style: AppTextStyles.bodyDescription),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(dialogContext),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AddressesCubit>().deleteAddress(address);
            },
            child: Text(s.delete),
          ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  final String label;
  const _DefaultBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.goldRoyal,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
      ),
      child: Text(label, style: AppTextStyles.badgeText),
    );
  }
}
