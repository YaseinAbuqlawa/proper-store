import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';

import 'package:admin/core/widgets/admin_text_field.dart';
import 'package:admin/features/products/presentation/cubit/categories_cubit.dart';

const _addCategoryValue = '__add__';

class FormBasicInfoCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController collectionController;
  final String? selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onAddCategoryTap;

  const FormBasicInfoCard({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.collectionController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onAddCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AdminTextField(
              controller: nameController,
              label: l.productFormFieldName,
              prefixIcon: Icons.shopping_bag_outlined,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            AdminTextField(
              controller: descriptionController,
              label: l.productFormFieldDesc,
              prefixIcon: Icons.notes_outlined,
              isRequired: true,
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            _CategoryDropdown(
              selected: selectedCategory,
              onChanged: onCategoryChanged,
              onAddTap: onAddCategoryTap,
            ),
            const SizedBox(height: 16),
            AdminTextField(
              controller: collectionController,
              label: l.productFormFieldCollection,
              prefixIcon: Icons.collections_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;
  final VoidCallback onAddTap;

  const _CategoryDropdown({
    required this.selected,
    required this.onChanged,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocSelector<CategoriesCubit, CategoriesState, List<String>>(
      selector: (state) {
        return state.categories;
      },
      builder: (context, categories) {
        return DropdownButtonFormField<String>(
          initialValue: categories.contains(selected) ? selected : null,
          decoration: InputDecoration(
            labelText: l.productFormFieldCategory,
            prefixIcon: const Icon(Icons.category_outlined, size: 18),
          ),
          validator: (v) =>
              v == null || v == _addCategoryValue ? l.errorRequired : null,
          items: [
            ...categories.map(
              (c) => DropdownMenuItem(value: c, child: Text(c)),
            ),
            DropdownMenuItem(
              value: _addCategoryValue,
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    size: 16,
                    color: AppColors.goldMuted,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l.productFormAddCategory,
                    style: const TextStyle(
                      color: AppColors.goldMuted,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (val) {
            if (val == _addCategoryValue) {
              onAddTap();
            } else {
              onChanged(val);
            }
          },
        );
      },
    );
  }
}

