import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/sizes/app_sizes.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/extensions.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/cart/presentation/widgets/cart_product_card.dart';
import 'package:proper_store/features/cart/presentation/widgets/submit_cart_button.dart';
import 'package:proper_store/generated/l10n.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, List<ProductModel>>(
      selector: (state) {
        return state.products.where((p) => p.quantity > 0).toList();
      },
      builder: (context, products) {
        final double screenWidth = MediaQuery.widthOf(context);
        final deviceType = AppSizes.getDeviceType(screenWidth);
        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).cartTitle)),
          body: SafeArea(
            child: products.isEmpty
                ? Center(child: Lottie.asset("empty.json", fit: BoxFit.fill))
                : CustomScrollView(
                    slivers: [
                      SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: deviceType == DeviceType.smallPhone
                              ? 5 / 2
                              : 3 / 1,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return CartProductCard(product: product);
                        },
                      ),
                      if (products.isNotEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [_TotalsCard()],
                          ),
                        ),
                    ],
                  ),
          ),
          bottomNavigationBar: products.isEmpty ? null : SubmitCartButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

class _TotalsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, List<ProductModel>>(
      selector: (state) {
        return state.products.where((p) => p.quantity > 0).toList();
      },
      builder: (context, products) {
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            color: AppColors.darkGray,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TotalRow(
                text: "الاجمالي قبل الخصم",
                value: products.totalPriceBeforeDiscount,
              ),
              _TotalRow(
                text: "اجمالي الخصم",
                valueColor: AppColors.successGreen,
                value: products.totalDiscount,
              ),
              Divider(thickness: .25, color: AppColors.textSecondary),
              _TotalRow(
                text: "الاجمالي",
                value: products.totalPriceAfterDiscount,
                isNetTotal: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String text;
  final double value;
  final bool isNetTotal;
  final Color? valueColor;
  const _TotalRow({
    this.valueColor,
    required this.text,
    required this.value,
    this.isNetTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: !isNetTotal
                ? AppTextStyles.bodyDescription.copyWith(color: valueColor)
                : AppTextStyles.productDetailsName,
          ),
          Text(
            value.toCurrency(),
            style: !isNetTotal
                ? AppTextStyles.productName.copyWith(color: valueColor)
                : AppTextStyles.productDetailsName.copyWith(
                    color: AppColors.goldRoyal,
                  ),
          ),
        ],
      ),
    );
  }
}
