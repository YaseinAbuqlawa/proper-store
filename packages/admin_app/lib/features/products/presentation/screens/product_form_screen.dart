import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/features/products/domain/use_cases/params/product_save_params.dart';
import 'package:admin/features/products/presentation/cubit/categories_cubit.dart';
import 'package:admin/features/products/presentation/cubit/product_form_cubit.dart';
import 'package:admin/features/products/presentation/cubit/product_form_data_cubit.dart';
import 'package:admin/features/products/presentation/cubit/product_form_data_state.dart';
import 'package:admin/features/products/presentation/widgets/add_category_dialog.dart';
import 'package:admin/features/products/presentation/widgets/form_basic_info_card.dart';
import 'package:admin/features/products/presentation/widgets/form_colors_section.dart';
import 'package:admin/features/products/presentation/widgets/form_main_image_card.dart';
import 'package:admin/features/products/presentation/widgets/form_pricing_card.dart';
import 'package:admin/features/products/presentation/widgets/form_section_header.dart';
import 'package:admin/features/products/presentation/widgets/reports_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';
import 'package:proper_store_shared/models/product_model.dart';

class ProductFormScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductFormScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final product = this.product;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProductFormCubit>()),
        BlocProvider(create: (_) => sl<CategoriesCubit>()..loadCategories()),
        BlocProvider(
          create: (_) {
            final cubit = sl<ProductFormDataCubit>();
            if (product != null) cubit.initForEdit(product);
            return cubit;
          },
        ),
      ],
      child: _ProductFormView(product: product),
    );
  }
}

class _ProductFormView extends StatefulWidget {
  final ProductModel? product;

  const _ProductFormView({this.product});

  @override
  State<_ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<_ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController collectionController;
  late final TextEditingController priceController;
  late final TextEditingController discountPercentageController;
  late final TextEditingController discountValueController;

  bool get isEdit => widget.product != null;

  bool _isUpdatingPricing = false;

  @override
  void initState() {
    super.initState();
    final product = widget.product;

    nameController = TextEditingController(text: product?.name ?? '');
    descriptionController = TextEditingController(
      text: product?.description ?? '',
    );
    collectionController = TextEditingController(
      text: product?.collection ?? '',
    );
    priceController = TextEditingController(
      text: product != null ? product.sellingPrice.toString() : '',
    );
    discountPercentageController = TextEditingController(
      text: product != null ? product.discountPercentage.toString() : '0',
    );
    discountValueController = TextEditingController(
      text: product != null ? product.discountValue.toString() : '0',
    );

    discountPercentageController.addListener(_onPercentageChanged);
    discountValueController.addListener(_onValueChanged);
    priceController.addListener(_onPriceChanged);
  }

  @override
  void dispose() {
    discountPercentageController.removeListener(_onPercentageChanged);
    discountValueController.removeListener(_onValueChanged);
    priceController.removeListener(_onPriceChanged);
    nameController.dispose();
    descriptionController.dispose();
    collectionController.dispose();
    priceController.dispose();
    discountPercentageController.dispose();
    discountValueController.dispose();
    super.dispose();
  }

  void _onPriceChanged() {
    if (_isUpdatingPricing) return;
    final price = double.tryParse(priceController.text) ?? 0;
    final pct = double.tryParse(discountPercentageController.text) ?? 0;
    if (price <= 0) return;
    _isUpdatingPricing = true;
    final value = context.read<ProductFormDataCubit>().computeDiscountValue(
      price: price,
      percentage: pct,
    );
    if (discountValueController.text != value)
      discountValueController.text = value;
    _isUpdatingPricing = false;
  }

  void _onPercentageChanged() {
    if (_isUpdatingPricing) return;
    if (discountPercentageController.text.isEmpty) return;
    final price = double.tryParse(priceController.text) ?? 0;
    final pct = double.tryParse(discountPercentageController.text) ?? 0;
    if (price <= 0) return;
    _isUpdatingPricing = true;
    final value = context.read<ProductFormDataCubit>().computeDiscountValue(
      price: price,
      percentage: pct,
    );
    if (discountValueController.text != value)
      discountValueController.text = value;
    _isUpdatingPricing = false;
  }

  void _onValueChanged() {
    if (_isUpdatingPricing) return;
    if (discountValueController.text.isEmpty) return;
    final price = double.tryParse(priceController.text) ?? 0;
    final value = double.tryParse(discountValueController.text) ?? 0;
    if (price <= 0) return;
    _isUpdatingPricing = true;
    final pct = context.read<ProductFormDataCubit>().computeDiscountPercentage(
      price: price,
      value: value,
    );
    if (discountPercentageController.text != pct)
      discountPercentageController.text = pct;
    _isUpdatingPricing = false;
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AddCategoryDialog(
        cubit: context.read<CategoriesCubit>(),
        onSaved: (name) =>
            context.read<ProductFormDataCubit>().selectCategory(name),
      ),
    );
  }

  void _submit(BuildContext context) {
    final l = S.of(context);
    final formData = context.read<ProductFormDataCubit>().state;
    if (!(_formKey.currentState?.validate() ?? false) ||
        formData.selectedCategory == null) {
      return;
    }
    if (!formData.hasMainImage) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.productFormErrorMainImageRequired,
      );
      return;
    }
    if (formData.productVariants.isEmpty) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.productFormErrorAtLeastOneColor,
      );
      return;
    }
    final variantWithoutImage = formData.productVariants
        .where((v) => !v.hasImages)
        .firstOrNull;
    if (variantWithoutImage != null) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.productFormErrorColorMustHaveImage,
      );
      return;
    }
    final collectionText = collectionController.text.trim();
    context.read<ProductFormCubit>().submit(
      ProductSaveParams(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        category: formData.selectedCategory!,
        collection: collectionText.isEmpty ? null : collectionText,
        sellingPrice: double.tryParse(priceController.text.trim()) ?? 0,
        discountPercentage:
            double.tryParse(discountPercentageController.text.trim()) ?? 0,
        discountValue:
            double.tryParse(discountValueController.text.trim()) ?? 0,
        existingMainImageUrl: formData.existingMainImageUrl,
        removedMainImageUrl: formData.removedMainImageUrl,
        newMainImageBytes: formData.newMainImageBytes,
        productVariants: formData.productVariants
            .map(
              (e) => ProductVariantSaveParams(
                name: e.name,
                color: e.color,
                stockQuantity: e.stockQuantity,
                existingImageUrls: e.existingImageUrls,
                newImageBytes: e.newImageBytes,
                removedImageUrls: e.removedImageUrls,
              ),
            )
            .toList(),
        removedVariantImageUrls: formData.removedVariantImageUrls,
        existingProduct: widget.product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state.status == CategoriesStatus.failure) {
              AppSnackbar.errorSnackbar(
                context: context,
                failureMessage: state.failure!.fromException(context: context),
              );
            }
          },
        ),
        BlocListener<ProductFormCubit, ProductFormState>(
          listener: (context, state) {
            state.whenOrNull(
              submitting: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AlertDialog(
                    content: Row(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(width: 16),
                        Text(l.loadingTitle),
                      ],
                    ),
                  ),
                );
              },
              success: () {
                Navigator.of(context, rootNavigator: true).pop();
                AppSnackbar.successSnackbar(
                  context: context,
                  message: isEdit
                      ? l.productFormSuccessEdit
                      : l.productFormSuccessAdd,
                );
                context.pop();
              },
              failure: (failure) {
                Navigator.of(context, rootNavigator: true).pop();
                AppSnackbar.errorSnackbar(
                  context: context,
                  failureMessage: failure.fromException(context: context),
                );
              },
            );
          },
        ),
      ],
      child: BlocSelector<ProductFormCubit, ProductFormState, bool>(
        selector: (state) => state.whenOrNull(submitting: () => true) ?? false,
        builder: (context, isSubmitting) {
          return BlocBuilder<ProductFormDataCubit, ProductFormData>(
            builder: (context, formData) {
              final formDataCubit = context.read<ProductFormDataCubit>();
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    isEdit ? l.productFormEditTitle : l.productFormAddTitle,
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 860),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FormSectionHeader(
                              icon: Icons.info_outline_rounded,
                              title: l.productFormSectionBasicInfo,
                            ),
                            const SizedBox(height: 10),
                            FormBasicInfoCard(
                              nameController: nameController,
                              descriptionController: descriptionController,
                              collectionController: collectionController,
                              selectedCategory: formData.selectedCategory,
                              onCategoryChanged: formDataCubit.selectCategory,
                              onAddCategoryTap: () =>
                                  _showAddCategoryDialog(context),
                            ),
                            const SizedBox(height: 28),
                            FormSectionHeader(
                              icon: Icons.sell_outlined,
                              title: l.productFormSectionPricing,
                            ),
                            const SizedBox(height: 10),
                            FormPricingCard(
                              priceController: priceController,
                              discountPercentageController:
                                  discountPercentageController,
                              discountValueController: discountValueController,
                            ),
                            const SizedBox(height: 28),
                            FormSectionHeader(
                              icon: Icons.photo_library_outlined,
                              title: l.productFormSectionMainImage,
                            ),
                            const SizedBox(height: 10),
                            FormMainImageCard(
                              existingImageUrl: formData.existingMainImageUrl,
                              newImageBytes: formData.newMainImageBytes,
                              onPickImage: formDataCubit.pickMainImage,
                            ),
                            const SizedBox(height: 28),
                            FormSectionHeader(
                              icon: Icons.palette_outlined,
                              title: l.productFormSectionColors,
                            ),
                            const SizedBox(height: 10),
                            FormColorsSection(
                              productVariants: formData.productVariants,
                              onAddColor: formDataCubit.addVariant,
                              onRemoveColor: formDataCubit.removeVariant,
                              onChanged: formDataCubit.notifyVariantChanged,
                            ),
                            if (isEdit) ...[
                              const SizedBox(height: 28),
                              FormSectionHeader(
                                icon: Icons.bar_chart_outlined,
                                title: l.productFormSectionReports,
                              ),
                              const SizedBox(height: 10),
                              ReportsCard(product: widget.product!),
                            ],
                            const SizedBox(height: 20),
                            AdminButton.primary(
                              label: isEdit
                                  ? l.productFormSave
                                  : l.productFormAddBtn,
                              onPressed: isSubmitting
                                  ? null
                                  : () => _submit(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
