import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/generated/l10n.dart';

class CheckoutAddressSelector extends StatelessWidget {
  final AddressModel? selectedAddress;
  final ValueChanged<AddressModel> onAddressSelected;

  const CheckoutAddressSelector({
    super.key,
    required this.selectedAddress,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: s.shippingAddressTitle),
        AppSpacing.verticalSpaceSmall,
        BlocBuilder<AddressesCubit, AddressesState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (addresses) => addresses.isEmpty
                  ? _AddAddressButton(s: s)
                  : _AddressList(
                      addresses: addresses,
                      selectedAddress: selectedAddress,
                      onSelected: onAddressSelected,
                      s: s,
                    ),
              orElse: () => _AddAddressButton(s: s),
            );
          },
        ),
      ],
    );
  }
}

class _AddressList extends StatelessWidget {
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final ValueChanged<AddressModel> onSelected;
  final S s;

  const _AddressList({
    required this.addresses,
    required this.selectedAddress,
    required this.onSelected,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...addresses.map(
          (address) => _AddressOption(
            address: address,
            isSelected: selectedAddress?.id == address.id,
            onTap: () => onSelected(address),
          ),
        ),
        AppSpacing.verticalSpaceSmall,
        _AddAddressButton(s: s),
      ],
    );
  }
}

class _AddressOption extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressOption({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: AppSpacing.small),
        padding: const EdgeInsets.all(AppSpacing.medium),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          border: Border.all(
            color:
                isSelected ? AppColors.goldRoyal : AppColors.textSecondary.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.goldRoyal : AppColors.textSecondary,
              size: 20,
            ),
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
                        _DefaultBadge(),
                      ],
                    ],
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Text(
                    '${address.street}، ${address.buildingNumber}، ${address.area}، ${address.city}',
                    style: AppTextStyles.bodyDescription,
                  ),
                  Text(
                    '${address.fullName} · ${address.phone}',
                    style: AppTextStyles.bodyDescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.goldRoyal,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
      ),
      child: Text(S.of(context).defaultBadge, style: AppTextStyles.badgeText),
    );
  }
}

class _AddAddressButton extends StatelessWidget {
  final S s;
  const _AddAddressButton({required this.s});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => context.push(AppRoutes.addAddress.path),
      icon: const Icon(Icons.add, size: 18),
      label: Text(s.addNewAddress),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.goldRoyal,
        side: const BorderSide(color: AppColors.goldRoyal),
        minimumSize: const Size.fromHeight(44),
      ),
    );
  }
}
