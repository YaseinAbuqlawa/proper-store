import 'dart:typed_data';

import 'package:admin/core/failures/app_failures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/app_dialog.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';

import 'package:admin/core/helpers/category_name_validator.dart';
import 'package:admin/core/helpers/image_compressor.dart';
import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/features/products/presentation/cubit/categories_cubit.dart';

class AddCategoryDialog extends StatefulWidget {
  final CategoriesCubit cubit;
  final void Function(String name) onSaved;

  const AddCategoryDialog({
    super.key,
    required this.cubit,
    required this.onSaved,
  });

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _nameController = TextEditingController();
  Uint8List? _imageBytes;
  String _pendingSaveName = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: AppConsts.imageQuality,
    );
    if (file == null) return;
    if (!mounted) return;
    AppDialog.showLoading(context);
    try {
      final raw = await file.readAsBytes();
      if (ImageCompressor.exceedsMaxBytes(raw)) {
        if (!mounted) return;
        Navigator.of(context).pop();
        AppSnackbar.errorSnackbar(
          context: context,
          failureMessage: S.of(context).imageTooLarge,
        );
        return;
      }
      final bytes = await ImageCompressor.compress(raw);
      if (!mounted) return;
      Navigator.of(context).pop();
      setState(() => _imageBytes = bytes);
    } catch (_) {
      if (!mounted) return;
      Navigator.of(context).pop();
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: S.of(context).imageProcessingFailed,
      );
    }
  }

  void _save() {
    final l = S.of(context);
    if (_nameController.text.trim().isEmpty) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.errorRequired,
      );
      return;
    }
    final normalized = CategoryNameValidator.normalize(_nameController.text);
    if (normalized == null) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.categoryNameInvalid,
      );
      return;
    }
    if (_imageBytes == null) {
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: l.categoryImageRequired,
      );
      return;
    }
    _pendingSaveName = normalized;
    widget.cubit.addCategory(normalized, _imageBytes!);
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listenWhen: (prev, curr) =>
            _pendingSaveName.isNotEmpty &&
            prev.status == CategoriesStatus.loading,
        listener: (context, state) {
          if (state.status == CategoriesStatus.failure) {
            AppSnackbar.errorSnackbar(
              context: context,
              failureMessage: state.failure!.fromException(context: context),
            );
            setState(() => _pendingSaveName = '');
          } else if (state.status == CategoriesStatus.success) {
            final savedName = _pendingSaveName;
            Navigator.of(context).pop();
            widget.onSaved(savedName);
          }
        },
        builder: (context, state) {
          final isSaving = _pendingSaveName.isNotEmpty &&
              state.status == CategoriesStatus.loading;
          return AlertDialog(
            title: Text(
              l.productFormAddCategory,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration:
                      InputDecoration(hintText: l.productFormCategoryHint),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: isSaving ? null : _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textSubtle),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _imageBytes != null
                        ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_photo_alternate_outlined,
                                color: AppColors.goldMuted,
                                size: 28,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l.productFormPickImage,
                                style: const TextStyle(
                                  color: AppColors.goldMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
            actions: [
              AdminButton.secondary(
                label: l.cancelBtn,
                onPressed: isSaving ? null : () => Navigator.of(context).pop(),
              ),
              AdminButton.primary(
                label: l.addBtn,
                onPressed: isSaving ? null : _save,
                isLoading: isSaving,
              ),
            ],
          );
        },
      ),
    );
  }
}
