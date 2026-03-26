import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/egypt_governorates.dart';

import 'package:admin/core/widgets/admin_button.dart';

class AddEditShippingDialog extends StatefulWidget {
  /// Pass non-null to edit an existing entry.
  final String? existingGovernorate;
  final double? existingCost;
  final Set<String> alreadyAdded;
  final Future<bool> Function(String governorate, double cost) onSave;

  const AddEditShippingDialog({
    super.key,
    this.existingGovernorate,
    this.existingCost,
    required this.alreadyAdded,
    required this.onSave,
  });

  bool get isEdit => existingGovernorate != null;

  @override
  State<AddEditShippingDialog> createState() => _AddEditShippingDialogState();
}

class _AddEditShippingDialogState extends State<AddEditShippingDialog> {
  final _costController = TextEditingController();
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedGovernorate;
  String _searchQuery = '';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _selectedGovernorate = widget.existingGovernorate;
      _costController.text = widget.existingCost?.toStringAsFixed(0) ?? '';
    }
    _searchController.addListener(
      () => setState(() => _searchQuery = _searchController.text.trim()),
    );
  }

  @override
  void dispose() {
    _costController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _availableGovernorates {
    final all = egyptGovernorates.keys.toList();
    final filtered = widget.isEdit
        ? all
        : all.where((g) => !widget.alreadyAdded.contains(g)).toList();
    if (_searchQuery.isEmpty) return filtered;
    return filtered
        .where((g) => g.contains(_searchQuery))
        .toList();
  }

  Future<void> _submit() async {
    if (_selectedGovernorate == null) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final cost = double.parse(_costController.text.trim());
    final success = await widget.onSave(_selectedGovernorate!, cost);
    if (mounted) {
      if (success) Navigator.of(context).pop();
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      title: Text(
        widget.isEdit ? l.editShippingCostTitle : l.addGovernorate,
        style: AppTextStyles.sectionTitle,
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isEdit) ...[
                _GovernorateSelector(
                  searchController: _searchController,
                  searchQuery: _searchQuery,
                  availableGovernorates: _availableGovernorates,
                  selected: _selectedGovernorate,
                  onSelect: (g) => setState(() => _selectedGovernorate = g),
                ),
                AppSpacing.verticalSpaceMedium,
              ] else ...[
                Text(
                  _selectedGovernorate ?? '',
                  style: AppTextStyles.productName,
                ),
                AppSpacing.verticalSpaceMedium,
              ],
              TextFormField(
                controller: _costController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l.shippingCostFieldLabel,
                  suffix: const Text('ج.م'),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return l.errorRequired;
                  if (double.tryParse(v) == null) {
                    return l.productFormErrorInvalidNumber;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        AdminButton.secondary(
          label: l.cancelBtn,
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
        ),
        AdminButton.primary(
          label: l.addBtn,
          onPressed: (_isSaving || _selectedGovernorate == null) ? null : _submit,
          isLoading: _isSaving,
        ),
      ],
    );
  }
}

class _GovernorateSelector extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final List<String> availableGovernorates;
  final String? selected;
  final ValueChanged<String> onSelect;

  const _GovernorateSelector({
    required this.searchController,
    required this.searchQuery,
    required this.availableGovernorates,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: l.searchGovernorateHint,
            prefixIcon: const Icon(Icons.search, size: 20),
          ),
        ),
        AppSpacing.verticalSpaceSmall,
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.goldRoyal.withAlpha(60)),
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          ),
          child: availableGovernorates.isEmpty
              ? Center(
                  child: Text(
                    l.noGovernoratesToAdd,
                    style: AppTextStyles.bodyDescription,
                  ),
                )
              : ListView.builder(
                  itemCount: availableGovernorates.length,
                  itemBuilder: (context, index) {
                    final gov = availableGovernorates[index];
                    final isSelected = gov == selected;
                    return ListTile(
                      dense: true,
                      title: Text(gov, style: AppTextStyles.productName),
                      selected: isSelected,
                      selectedColor: AppColors.goldRoyal,
                      selectedTileColor: AppColors.goldRoyal.withAlpha(20),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColors.goldRoyal,
                              size: 18,
                            )
                          : null,
                      onTap: () => onSelect(gov),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
