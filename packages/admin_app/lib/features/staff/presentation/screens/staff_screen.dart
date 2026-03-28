import 'package:admin/core/di/injection_container.dart';
import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart';
import 'package:admin/features/staff/presentation/widgets/add_staff_dialog.dart';
import 'package:admin/features/staff/presentation/widgets/staff_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StaffCubit>()..loadStaff(),
      child: const _StaffView(),
    );
  }
}

class _StaffView extends StatelessWidget {
  const _StaffView();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.staffManagementTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.person_add_outlined),
        label: Text(s.addStaffBtn),
        backgroundColor: AppColors.goldRoyal,
        foregroundColor: AppColors.blackDeep,
      ),
      body: BlocConsumer<StaffCubit, StaffState>(
        listener: (context, state) {
          state.whenOrNull(
            mutationFailure: (message, _) {
              final text = FirebaseFailure(
                code: message,
              ).fromException(context: context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(text),
                  backgroundColor: AppColors.errorRed,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) => _buildList(context, s, items),
            mutationFailure: (_, items) => _buildList(context, s, items),
            failure: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.errorRed,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    FirebaseFailure(
                      code: message,
                    ).fromException(context: context),
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.read<StaffCubit>().loadStaff(),
                    child: Text(s.retryBtn),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, S s, List items) {
    if (items.isEmpty) {
      return Center(
        child: Text(s.customersEmpty, style: AppTextStyles.bodyDescription),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) => StaffCard(item: items[i]),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<StaffCubit>(),
        child: const AddStaffDialog(),
      ),
    );
  }
}
