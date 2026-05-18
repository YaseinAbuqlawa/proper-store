import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/di/injection_container.dart';
import 'package:proper_store/core/helpers/auth_guard_dialog.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/sizes/app_sizes.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class SubmitCartButton extends StatelessWidget {
  const SubmitCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: AppColors.goldRoyal, blurRadius: 8)],
      ),
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 40),
      child: ElevatedButton(
        onPressed: () => _onCheckout(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).completeCheckout,
              style: AppTextStyles.productDetailsName.copyWith(
                color: AppColors.blackDeep,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: [
                BlocSelector<CartCubit, CartState, double>(
                  selector: (state) {
                    return state.products.totalPriceAfterDiscount;
                  },
                  builder: (context, totalPrice) {
                    return Text(
                      totalPrice.toCurrency(),
                      style: AppTextStyles.productName.copyWith(
                        color: AppColors.blackDeep,
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 20,
                  width: .5,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                const Icon(Icons.arrow_back, size: AppSizes.iconSizeMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCheckout(BuildContext context) async {
    final products = context.read<CartCubit>().state.products;
    if (products.isEmpty) return;

    final needsAuth = sl<FirebaseAuth>().currentUser == null;
    if (needsAuth) {
      final proceed = await AuthGuardDialog.show(context);
      if (!proceed || !context.mounted) return;
    }
    await context.read<AddressesCubit>().getAddresses();
    if (context.mounted) context.push(AppRoutes.checkout.path);
  }
}
