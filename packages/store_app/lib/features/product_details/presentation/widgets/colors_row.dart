import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/models/product_variant.dart';

import 'package:proper_store/core/widgets/oos_diagonal_painter.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';

class ColorsRow extends StatelessWidget {
  final List<ProductVariant> productColors;

  /// Variant hexKeys that are out of stock. Circles for these keys will be
  /// faded and show a diagonal strike-through.
  final List<String> outOfStockVariants;

  /// When false, tapping an OOS circle is a no-op (used in the add-to-cart
  /// dialog where selecting an OOS variant makes no sense).
  final bool allowSelectOos;

  const ColorsRow({
    super.key,
    required this.productColors,
    this.outOfStockVariants = const [],
    this.allowSelectOos = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductDetailsCubit, ProductDetailsState, ProductVariant?>(
      selector: (state) {
        return state.maybeWhen(
          orElse: () => null,
          success: (productDetails, activeIndex, relatedProductsList) =>
              productDetails?.selectedColor,
        );
      },
      builder: (context, selectedColor) {
        return Wrap(
          children: List.generate(productColors.length, (index) {
            selectedColor ??= productColors[0];
            final productColor = productColors[index];
            final isSelected = productColor == selectedColor;
            final isOos = outOfStockVariants.contains(productColor.hexKey);

            Widget circleContent = AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                boxShadow: [
                  if (isSelected)
                    const BoxShadow(
                      color: AppColors.goldRoyal,
                      blurRadius: 5,
                    ),
                ],
                border: isSelected
                    ? Border.all(color: AppColors.goldRoyal)
                    : null,
                borderRadius: BorderRadius.circular(50),
                color: productColor.color,
              ),
              width: 30,
              height: 30,
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: productColor.color.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    )
                  : null,
            );

            Widget tile = isOos
                ? Opacity(
                    opacity: 0.35,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        circleContent,
                        const SizedBox(
                          width: 30,
                          height: 30,
                          child: CustomPaint(painter: OosDiagonalPainter()),
                        ),
                      ],
                    ),
                  )
                : circleContent;

            return Tooltip(
              message: productColor.name,
              child: InkWell(
                onTap: (isOos && !allowSelectOos)
                    ? null
                    : () {
                        context
                            .read<ProductDetailsCubit>()
                            .selectColor(productColor);
                      },
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: tile,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
