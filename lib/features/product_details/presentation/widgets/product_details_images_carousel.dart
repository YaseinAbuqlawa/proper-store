import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/app_network_image.dart';
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart';

class ProductDetailsImagesCarousel extends StatelessWidget {
  final double screenHeight;
  final List<String> imageUrls;
  final String productId;
  const ProductDetailsImagesCarousel({
    super.key,
    required this.screenHeight,
    required this.productId,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
      selector: (state) {
        return state.maybeWhen(
          orElse: () => 0,
          success: (productDetails, activeIndex, relatedProductsList) =>
              activeIndex,
        );
      },
      builder: (context, activeIndex) {
        return CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            final String productImage = imageUrls[index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              height: screenHeight * .4,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Hero(
                    tag: productImage + productId,
                    child: AppNetworkImage(imageUrl: productImage),
                  ),
                  if (index == activeIndex)
                    Align(
                      alignment: AlignmentGeometry.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.borderRadiusLarge,
                                ),
                                child: InteractiveViewer(
                                  maxScale: 5,
                                  child: AppNetworkImage(
                                    imageUrl: productImage,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.zoom_in,
                          color: AppColors.blackDeep,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              context.read<ProductDetailsCubit>().setActiveIndex(index);
            },
            aspectRatio: 1,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            initialPage: 0,
            padEnds: true,
            enlargeFactor: .1,
            enlargeCenterPage: true,
          ),
        );
      },
    );
  }
}
