import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/helpers/app_snackbar.dart';
import 'package:proper_store/core/router/app_routes.dart';
import 'package:proper_store/features/addresses/data/models/address_model.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/features/addresses/presentation/widgets/address_card.dart';
import 'package:proper_store/generated/l10n.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressesCubit>().getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.myAddresses)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addAddress.path),
        backgroundColor: AppColors.goldRoyal,
        child: const Icon(Icons.add, color: AppColors.blackDeep),
      ),
      body: BlocConsumer<AddressesCubit, AddressesState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (message) {
              if (!context.mounted) return;
              AppSnackbar.errorSnackbar(
                context: context,
                failureMessage: message,
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (addresses) => addresses.isEmpty
                ? _EmptyAddresses(s: s)
                : _AddressesList(addresses: addresses),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class _EmptyAddresses extends StatelessWidget {
  final S s;
  const _EmptyAddresses({required this.s});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          AppSpacing.verticalSpaceMedium,
          Text(s.noAddressesYet, style: AppTextStyles.bodyDescription),
          AppSpacing.verticalSpaceSmall,
          Text(s.addFirstAddress, style: AppTextStyles.bodyDescription),
        ],
      ),
    );
  }
}

class _AddressesList extends StatelessWidget {
  final List<AddressModel> addresses;
  const _AddressesList({required this.addresses});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppSpacing.screenPadding,
      itemCount: addresses.length,
      separatorBuilder: (context, index) => AppSpacing.verticalSpaceSmall,
      itemBuilder: (context, index) => AddressCard(address: addresses[index]),
    );
  }
}
