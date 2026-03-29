import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';
import 'package:proper_store_shared/models/address_model.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';

import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:proper_store/features/checkout/presentation/widgets/checkout_address_selector.dart';
import 'package:proper_store/features/checkout/presentation/widgets/checkout_order_summary.dart';

class CheckoutScreen extends StatefulWidget {
  /// When non-null, checkout applies only to these items (Buy Now flow).
  /// The user's cart is left untouched.
  final List<CartItemModel>? buyNowItems;

  const CheckoutScreen({super.key, this.buyNowItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AddressModel? _selectedAddress;
  double? _shippingCost;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await context.read<CheckoutCubit>().loadShippingCost();
      if (!mounted) return;
      final addressesCubit = context.read<AddressesCubit>();
      addressesCubit.state.maybeWhen(
        loaded: (addresses) => _preselectDefault(addresses),
        orElse: () async {
          await addressesCubit.getAddresses();
          if (!mounted) return;
          addressesCubit.state.maybeWhen(
            loaded: (addresses) => _preselectDefault(addresses),
            orElse: () {},
          );
        },
      );
    });
  }

  void _preselectDefault(List<AddressModel> addresses) {
    if (addresses.isEmpty) return;
    final defaultAddr = addresses.firstWhere(
      (a) => a.isDefault,
      orElse: () => addresses.first,
    );
    _onAddressSelected(defaultAddr);
  }

  void _onAddressSelected(AddressModel address) {
    final cost = context.read<CheckoutCubit>().shippingCostFor(address.city);
    setState(() {
      _selectedAddress = address;
      _shippingCost = cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (orderId) {
            // Only clear the cart for the regular cart checkout flow.
            // Buy Now orders leave the cart untouched.
            if (widget.buyNowItems == null) {
              context.read<CartCubit>().clearCart();
            }
            if (!context.mounted) return;
            context.pushReplacement(
              AppRoutes.orderConfirmation.path,
              extra: orderId,
            );
          },
          outOfStock: (productName, variantName, available) {
            if (!context.mounted) return;
            final label = variantName.isNotEmpty
                ? '$productName ($variantName)'
                : productName;
            final displayMessage = available == 0
                ? S.of(context).outOfStockProduct(label)
                : S.of(context).lowStockProduct(label, available);
            AppSnackbar.errorSnackbar(
              context: context,
              failureMessage: displayMessage,
            );
          },
          failure: (message) {
            if (!context.mounted) return;
            AppSnackbar.errorSnackbar(
              context: context,
              failureMessage: message,
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(s.checkoutTitle)),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final isPlacing = state.maybeWhen(
              placing: () => true,
              orElse: () => false,
            );
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: AppSpacing.screenPadding.copyWith(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.verticalSpaceSmall,
                      CheckoutOrderSummary(
                        shippingCost: _shippingCost,
                        buyNowItems: widget.buyNowItems,
                      ),
                      AppSpacing.verticalSpaceLarge,
                      BlocListener<AddressesCubit, AddressesState>(
                        listener: (context, addrState) {
                          addrState.maybeWhen(
                            loaded: (addresses) {
                              if (_selectedAddress == null &&
                                  addresses.isNotEmpty) {
                                _preselectDefault(addresses);
                              } else if (addresses.isNotEmpty &&
                                  _selectedAddress != null) {
                                final stillExists = addresses.any(
                                  (a) => a.id == _selectedAddress!.id,
                                );
                                if (!stillExists) {
                                  _preselectDefault(addresses);
                                }
                              }
                            },
                            orElse: () {},
                          );
                        },
                        child: CheckoutAddressSelector(
                          selectedAddress: _selectedAddress,
                          onAddressSelected: _onAddressSelected,
                        ),
                      ),
                      AppSpacing.verticalSpaceLarge,
                      _PaymentMethodSection(s: s),
                    ],
                  ),
                ),
                if (isPlacing)
                  const ColoredBox(
                    color: Colors.black54,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
        bottomNavigationBar: _PlaceOrderButton(onPressed: _onPlaceOrder),
      ),
    );
  }

  void _onPlaceOrder() {
    final s = S.of(context);
    if (_selectedAddress == null) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: s.noAddressSelected,
      );
      return;
    }
    if (_shippingCost == null) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: s.shippingNotAvailable,
      );
      return;
    }
    final products =
        widget.buyNowItems ?? context.read<CartCubit>().state.products;
    context.read<CheckoutCubit>().placeOrder(
      products: products,
      shippingAddress: _selectedAddress!,
      shippingCost: _shippingCost!,
    );
  }
}

class _PaymentMethodSection extends StatelessWidget {
  final S s;
  const _PaymentMethodSection({required this.s});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: s.paymentMethodTitle),
        AppSpacing.verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.all(AppSpacing.medium),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            border: Border.all(
              color: AppColors.goldRoyal.withValues(alpha: 0.4),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.payments_outlined,
                color: AppColors.goldRoyal,
                size: 22,
              ),
              AppSpacing.horizontalSpaceSmall,
              Text(s.paymentCOD, style: AppTextStyles.productName),
              const Spacer(),
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.goldRoyal,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaceOrderButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _PlaceOrderButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      buildWhen: (prev, curr) =>
          curr.maybeWhen(placing: () => true, orElse: () => false) !=
          prev.maybeWhen(placing: () => true, orElse: () => false),
      builder: (context, state) {
        final isPlacing = state.maybeWhen(
          placing: () => true,
          orElse: () => false,
        );
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: ElevatedButton(
            onPressed: isPlacing ? null : onPressed,
            child: isPlacing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(s.placeOrderButton, style: AppTextStyles.buttonText),
          ),
        );
      },
    );
  }
}
