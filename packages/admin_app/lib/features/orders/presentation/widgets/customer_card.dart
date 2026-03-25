import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import '../cubit/order_details_state.dart';
import 'order_details_style.dart';

class CustomerCard extends StatelessWidget {
  final OrderDetailsState state;

  const CustomerCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final addr = state.order?.shippingAddress;
    final customerName = state.customer?.name ?? addr?.fullName ?? '';

    return Container(
      decoration: orderDetailsCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l.customerDataLabel,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                      color: orderDetailsStone400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.person_outline,
                  color: orderDetailsStone400,
                  size: 18,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: orderDetailsStone100),
          if (state.isLoadingCustomer)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LabeledField(
                    label: l.customerNameLabel,
                    value: customerName,
                    copyConfirmation: l.nameCopiedLabel,
                  ),
                  const SizedBox(height: 16),
                  _LabeledField(
                    label: l.customerPhoneLabel,
                    value: addr?.phone ?? '',
                    valueTextDirection: TextDirection.ltr,
                    copyConfirmation: l.phoneCopiedLabel,
                  ),
                  if (addr != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l.orderShippingAddressLabel,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: orderDetailsStone400,
                            ),
                          ),
                        ),
                        _CopyButton(
                          label: l.copyAddressLabel,
                          confirmation: l.addressCopiedLabel,
                          textToCopy: [
                            "محافطة: ${addr.city}",
                            "منطقة: ${addr.area}",
                            "الشارع: ${addr.street}",
                            "العقار: ${addr.buildingNumber}",
                            if (addr.floor.isNotEmpty) "الدور: ${addr.floor}",
                            if (addr.apartment.isNotEmpty)
                              "الشقة: ${addr.apartment}",
                          ].join(' - '),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _AddressRow(label: l.cityLabel, value: addr.city),
                    _AddressRow(label: l.areaLabel, value: addr.area),
                    _AddressRow(label: l.streetLabel, value: addr.street),
                    _AddressRow(
                      label: l.buildingNumberLabel,
                      value: addr.buildingNumber,
                    ),
                    if (addr.floor.isNotEmpty)
                      _AddressRow(label: l.floorLabel, value: addr.floor),
                    if (addr.apartment.isNotEmpty)
                      _AddressRow(
                        label: l.apartmentLabel,
                        value: addr.apartment,
                      ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final String label;
  final String textToCopy;
  final String confirmation;

  const _CopyButton({
    required this.label,
    required this.textToCopy,
    required this.confirmation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: textToCopy));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(confirmation),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.copy_outlined, size: 14, color: orderDetailsGold),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: orderDetailsGold,
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String value;
  final TextDirection? valueTextDirection;
  final String? copyConfirmation;

  const _LabeledField({
    required this.label,
    required this.value,
    this.valueTextDirection,
    this.copyConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: orderDetailsStone400,
                ),
              ),
            ),
            if (copyConfirmation != null && value.isNotEmpty)
              _CopyButton(
                label: l.copyLabel,
                textToCopy: value,
                confirmation: copyConfirmation!,
              ),
          ],
        ),
        const SizedBox(height: 2),
        Directionality(
          textDirection: valueTextDirection ?? TextDirection.rtl,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: orderDetailsStone900,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddressRow extends StatelessWidget {
  final String label;
  final String value;

  const _AddressRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: orderDetailsStone400),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: orderDetailsStone900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
