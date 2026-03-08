import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/products/domain/entities/product_filter.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/home/data/models/category_model.dart';
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:proper_store/features/products/presentation/models/products_screen_args.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoriesListView extends StatelessWidget {
  const HomeCategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      HomeCubit,
      HomeState,
      ({List<CategoryModel> categories, bool isLoading})
    >(
      selector: (state) {
        return (
          categories: state.bagCategoriesList,
          isLoading: state.categoriesState.name == "loading",
        );
      },
      builder: (context, data) {
        final displayList = data.isLoading
            ? List.filled(
                5,
                CategoryModel(id: 'dummy_id', name: 'اسم القسم', imageUrl: ''),
              )
            : data.categories;

        if (!data.isLoading && displayList.isEmpty) {
          return const SizedBox.shrink();
        }

        return Skeletonizer(
          enabled: data.isLoading,
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final CategoryModel categoryModel = displayList[index];
                return _CategoryButton(
                  categoryModel: categoryModel,
                  onTap: data.isLoading
                      ? null
                      : () => context.push(
                            AppRoutes.products.path,
                            extra: ProductsScreenArgs(
                              title: categoryModel.name,
                              filter: ProductFilterByCategory(
                                categoryModel.name,
                              ),
                            ),
                          ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final CategoryModel categoryModel;
  final void Function()? onTap;

  const _CategoryButton({required this.categoryModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(left: 10),
        decoration: const BoxDecoration(
          color: AppColors.darkGray,
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Skeleton.replace(
              child: CachedNetworkImage(
                imageUrl: categoryModel.imageUrl,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withAlpha(150),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => const SizedBox.shrink(),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
            Center(
              child: Text(
                categoryModel.name,
                style: AppTextStyles.buttonText.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
