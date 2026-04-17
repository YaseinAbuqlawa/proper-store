import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';

import 'package:admin/core/helpers/image_compressor.dart';
import 'package:admin/core/widgets/admin_button.dart';
import 'package:admin/core/widgets/confirm_delete_dialog.dart';
import 'package:admin/features/products/presentation/models/product_variant_entry.dart';

class ProductVariantEditor extends StatefulWidget {
  final ProductVariantEntry entry;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const ProductVariantEditor({
    super.key,
    required this.entry,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<ProductVariantEditor> createState() => _ProductVariantEditorState();
}

class _ProductVariantEditorState extends State<ProductVariantEditor> {
  late final TextEditingController nameCtrl;
  late final TextEditingController stockCtrl;
  late bool _isLight;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.entry.name);
    stockCtrl = TextEditingController(
      text: widget.entry.stockQuantity.toString(),
    );
    _isLight = _computeIsLight(widget.entry.color);
  }

  static bool _computeIsLight(Color color) => color.computeLuminance() > 0.7;

  @override
  void didUpdateWidget(covariant ProductVariantEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.color != widget.entry.color) {
      _isLight = _computeIsLight(widget.entry.color);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    stockCtrl.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final files = await ImagePicker().pickMultiImage(
      imageQuality: AppConsts.imageQuality,
    );
    if (files.isEmpty) return;
    try {
      final rawList = await Future.wait(files.map((f) => f.readAsBytes()));
      final accepted =
          rawList.where((b) => !ImageCompressor.exceedsMaxBytes(b)).toList();
      final rejectedCount = rawList.length - accepted.length;
      if (rejectedCount > 0 && mounted) {
        AppSnackbar.errorSnackbar(
          context: context,
          failureMessage: S.of(context).imagesSkippedTooLarge(rejectedCount),
        );
      }
      if (accepted.isEmpty) return;
      final bytes = await Future.wait(accepted.map(ImageCompressor.compress));
      if (!mounted) return;
      setState(() => widget.entry.newImageBytes.addAll(bytes));
      widget.onChanged();
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.errorSnackbar(
        context: context,
        failureMessage: S.of(context).imageProcessingFailed,
      );
    }
  }

  void removeExistingImage(int index) {
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        message: S.of(context).confirmDeleteImage,
        onConfirm: () {
          setState(() {
            widget.entry.removedImageUrls
                .add(widget.entry.existingImageUrls[index]);
            widget.entry.existingImageUrls.removeAt(index);
          });
          widget.onChanged();
        },
      ),
    );
  }

  void removeNewImage(int index) {
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        message: S.of(context).confirmDeleteImage,
        onConfirm: () {
          setState(() => widget.entry.newImageBytes.removeAt(index));
          widget.onChanged();
        },
      ),
    );
  }

  void pickColor() {
    Color tempColor = widget.entry.color;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          S.of(context).productFormPickColor,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (c) => tempColor = c,
            enableAlpha: false,
            labelTypes: const [],
            pickerAreaHeightPercent: 0.5,
          ),
        ),
        actions: [
          AdminButton.secondary(
            label: S.of(context).cancelBtn,
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          AdminButton.primary(
            label: S.of(context).addBtn,
            onPressed: () {
              setState(() {
                widget.entry.color = tempColor;
                _isLight = _computeIsLight(tempColor);
              });
              widget.onChanged();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final color = widget.entry.color;
    final isLight = _isLight;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5, color: color),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: pickColor,
                          child: Tooltip(
                            message: l.productFormPickColor,
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: color,
                                border: Border.all(
                                  color: isLight
                                      ? AppColors.textSubtle
                                      : AppColors.darkGray,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.colorize_rounded,
                                size: 20,
                                color: isLight
                                    ? AppColors.blackDeep
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: nameCtrl,
                            decoration: InputDecoration(
                              labelText: l.productFormColorName,
                              prefixIcon: const Icon(
                                Icons.label_outline,
                                size: 18,
                              ),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? l.errorRequired
                                    : null,
                            onChanged: (v) {
                              widget.entry.name = v;
                              widget.onChanged();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: stockCtrl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: l.productFormColorStock,
                              prefixIcon: const Icon(
                                Icons.inventory_2_outlined,
                                size: 18,
                              ),
                            ),
                            onChanged: (v) {
                              widget.entry.stockQuantity = int.tryParse(v) ?? 0;
                              widget.onChanged();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.errorRed,
                          ),
                          tooltip: l.deleteBtn,
                          onPressed: widget.onRemove,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...widget.entry.existingImageUrls.asMap().entries.map(
                            (e) => _ImageThumb(
                              onRemove: () => removeExistingImage(e.key),
                              child: CachedNetworkImage(
                                imageUrl: e.value,
                                fit: BoxFit.cover,
                                errorWidget: (_, _, _) =>
                                    const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                          ...widget.entry.newImageBytes.asMap().entries.map(
                            (e) => _ImageThumb(
                              onRemove: () => removeNewImage(e.key),
                              child: Image.memory(e.value, fit: BoxFit.cover),
                            ),
                          ),
                          GestureDetector(
                            onTap: pickImages,
                            child: Container(
                              width: 72,
                              height: 72,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.goldMuted),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate_outlined,
                                color: AppColors.goldMuted,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  final Widget child;
  final VoidCallback onRemove;

  const _ImageThumb({required this.child, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 72, height: 72, child: child),
          ),
          Positioned(
            top: -5,
            right: 3,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
