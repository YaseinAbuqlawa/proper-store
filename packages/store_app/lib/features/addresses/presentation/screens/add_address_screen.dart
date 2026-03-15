import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';
import 'package:proper_store_shared/models/address_model.dart';

import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/features/addresses/presentation/widgets/address_text_field.dart';
import 'package:proper_store/features/addresses/presentation/widgets/area_dropdown.dart';
import 'package:proper_store/features/addresses/presentation/widgets/governorate_dropdown.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingController;
  late final TextEditingController _floorController;
  late final TextEditingController _apartmentController;
  String? _selectedCity;
  String? _selectedArea;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _streetController = TextEditingController();
    _buildingController = TextEditingController();
    _floorController = TextEditingController();
    _apartmentController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<AddressesCubit>().addAddress(
      AddressModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: _labelController.text.trim(),
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        city: _selectedCity!,
        area: _selectedArea!,
        street: _streetController.text.trim(),
        buildingNumber: _buildingController.text.trim(),
        floor: _floorController.text.trim(),
        apartment: _apartmentController.text.trim(),
        isDefault: _isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocListener<AddressesCubit, AddressesState>(
      listenWhen: (previous, current) =>
          previous.maybeWhen(loading: () => true, orElse: () => false),
      listener: (context, state) {
        state.whenOrNull(
          loaded: (_) {
            if (!context.mounted) return;
            Navigator.pop(context);
            AppSnackbar.successSnackbar(
              context: context,
              message: s.addressSaved,
            );
          },
          failure: (message) {
            if (!context.mounted) return;
            AppSnackbar.errorSnackbar(
              context: context,
              failureMessage: message,
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(s.addAddressTitle)),
        body: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AddressTextField(
                  controller: _labelController,
                  label: s.addressLabelLabel,
                  hint: s.addressLabelHint,
                ),
                AppSpacing.verticalSpaceMedium,
                AddressTextField(
                  controller: _fullNameController,
                  label: s.fullNameLabel,
                  hint: s.enterFullNameHint,
                ),
                AppSpacing.verticalSpaceMedium,
                AddressTextField(
                  controller: _phoneController,
                  label: s.phoneNumberLabel,
                  keyboardType: TextInputType.phone,
                  isPhone: true,
                ),
                AppSpacing.verticalSpaceMedium,
                GovernorateDropdown(
                  value: _selectedCity,
                  label: s.cityLabel,
                  onChanged: (value) => setState(() {
                    _selectedCity = value;
                    _selectedArea = null;
                  }),
                ),
                AppSpacing.verticalSpaceMedium,
                AreaDropdown(
                  key: ValueKey(_selectedCity),
                  selectedCity: _selectedCity,
                  initialValue: _selectedArea,
                  label: s.areaLabel,
                  onChanged: _selectedCity == null
                      ? null
                      : (value) => setState(() => _selectedArea = value),
                ),
                AppSpacing.verticalSpaceMedium,
                AddressTextField(
                  controller: _streetController,
                  label: s.streetLabel,
                ),
                AppSpacing.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                      child: AddressTextField(
                        controller: _buildingController,
                        label: s.buildingNumberLabel,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    AppSpacing.horizontalSpaceMedium,
                    Expanded(
                      child: AddressTextField(
                        controller: _floorController,
                        label: s.floorLabel,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    AppSpacing.horizontalSpaceMedium,
                    Expanded(
                      child: AddressTextField(
                        controller: _apartmentController,
                        label: s.apartmentLabel,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceSmall,
                SwitchListTile(
                  value: _isDefault,
                  onChanged: (value) => setState(() => _isDefault = value),
                  title: Text(
                    s.setAsDefault,
                    style: AppTextStyles.bodyDescription,
                  ),
                  activeThumbColor: AppColors.goldRoyal,
                  contentPadding: EdgeInsets.zero,
                ),
                AppSpacing.verticalSpaceLarge,
                BlocBuilder<AddressesCubit, AddressesState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return ElevatedButton(
                      onPressed: isLoading ? null : () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldRoyal,
                        padding: AppSpacing.buttonPadding,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.blackDeep,
                              ),
                            )
                          : Text(
                              s.saveAddress,
                              style: AppTextStyles.buttonText,
                            ),
                    );
                  },
                ),
                AppSpacing.verticalSpaceLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
