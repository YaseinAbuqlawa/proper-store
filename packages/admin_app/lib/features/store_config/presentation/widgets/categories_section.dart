import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/category_model.dart';

import 'package:admin/core/widgets/confirm_delete_dialog.dart';
import 'package:admin/features/products/presentation/widgets/form_section_header.dart';
import 'package:admin/features/store_config/presentation/cubit/store_config_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocBuilder<StoreConfigCubit, StoreConfigState>(
      buildWhen: (prev, curr) {
        if (curr is! StoreConfigLoaded || prev is! StoreConfigLoaded) {
          return true;
        }
        return prev.categories != curr.categories ||
            prev.isSavingCategory != curr.isSavingCategory;
      },
      builder: (context, state) {
        if (state is! StoreConfigLoaded) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(AppSpacing.large),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            border: Border.all(color: Colors.black.withAlpha(15)),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormSectionHeader(
                icon: Icons.category_outlined,
                title: l.categoriesSectionTitle,
              ),
              AppSpacing.verticalSpaceMedium,
              _CategoryGrid(
                categories: state.categories,
                isSaving: state.isSavingCategory,
              ),
              AppSpacing.verticalSpaceMedium,
              const Divider(),
              AppSpacing.verticalSpaceSmall,
              _AddCategoryForm(isSaving: state.isSavingCategory),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final bool isSaving;

  const _CategoryGrid({required this.categories, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    if (categories.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
        child: Center(
          child: Text(l.categoriesEmpty, style: AppTextStyles.bodyDescription),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.medium,
      runSpacing: AppSpacing.medium,
      children: categories
          .map((c) => _CategoryChip(category: c, isSaving: isSaving))
          .toList(),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSaving;

  const _CategoryChip({required this.category, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 88,
          padding: const EdgeInsets.all(AppSpacing.small),
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            border: Border.all(color: Colors.black.withAlpha(15)),
          ),
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: category.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, _, _) => const _PlaceholderIcon(),
                        )
                      : const _PlaceholderIcon(),
                ),
              ),
              const SizedBox(height: AppSpacing.extraSmall),
              Text(
                category.name,
                style: AppTextStyles.navLabel,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned(
          top: -6,
          left: -6,
          child: GestureDetector(
            onTap: isSaving
                ? null
                : () => showDialog(
                      context: context,
                      builder: (_) => ConfirmDeleteDialog(
                        message: l.confirmDeleteCategory,
                        onConfirm: () => context
                            .read<StoreConfigCubit>()
                            .deleteCategory(category),
                      ),
                    ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.errorRed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.goldRoyal.withAlpha(30),
      child: const Icon(Icons.image_outlined, color: AppColors.goldMuted),
    );
  }
}

class _AddCategoryForm extends StatefulWidget {
  final bool isSaving;

  const _AddCategoryForm({required this.isSaving});

  @override
  State<_AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<_AddCategoryForm> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (mounted) setState(() => _imageBytes = bytes);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).categoryImageRequired)),
      );
      return;
    }

    final success = await context.read<StoreConfigCubit>().addCategory(
          _nameController.text.trim(),
          _imageBytes!,
        );

    if (success && mounted) {
      _nameController.clear();
      setState(() => _imageBytes = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.addCategory,
                  style: AppTextStyles.navLabel.copyWith(
                    color: AppColors.textSubtle,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: l.categoryNameHint,
                    labelText: l.categoryNameLabel,
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l.errorRequired : null,
                ),
                const SizedBox(height: AppSpacing.medium),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: widget.isSaving ? null : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.darkGray,
                      foregroundColor: AppColors.whiteColor,
                    ),
                    child: widget.isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l.addNewCategoryBtn),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.large),
          GestureDetector(
            onTap: widget.isSaving ? null : _pickImage,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius:
                    BorderRadius.circular(AppSpacing.borderRadiusMedium),
                border: Border.all(
                  color: _imageBytes != null
                      ? AppColors.goldRoyal
                      : Colors.black.withAlpha(30),
                  style: _imageBytes != null
                      ? BorderStyle.solid
                      : BorderStyle.solid,
                  width: _imageBytes != null ? 2 : 1,
                ),
              ),
              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadiusMedium - 1,
                      ),
                      child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_photo_alternate_outlined,
                          color: AppColors.goldMuted,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l.uploadPhoto,
                          style: AppTextStyles.navLabel.copyWith(
                            color: AppColors.textSubtle,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
