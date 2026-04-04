import 'package:admin/core/failures/app_failures.dart';
import 'package:admin/features/auth/domain/entities/staff_role.dart';
import 'package:admin/features/staff/domain/entities/staff_list_item.dart';
import 'package:admin/features/staff/domain/use_cases/change_password_use_case.dart';
import 'package:admin/features/staff/domain/use_cases/change_role_use_case.dart';
import 'package:admin/features/staff/domain/use_cases/create_staff_use_case.dart';
import 'package:admin/features/staff/domain/use_cases/delete_staff_use_case.dart';
import 'package:admin/features/staff/domain/use_cases/get_staff_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'staff_cubit.freezed.dart';
part 'staff_state.dart';

@injectable
class StaffCubit extends Cubit<StaffState> {
  final GetStaffUseCase _getStaff;
  final CreateStaffUseCase _createStaff;
  final ChangeRoleUseCase _changeRole;
  final ChangePasswordUseCase _changePassword;
  final DeleteStaffUseCase _deleteStaff;

  StaffCubit({
    required GetStaffUseCase getStaff,
    required CreateStaffUseCase createStaff,
    required ChangeRoleUseCase changeRole,
    required ChangePasswordUseCase changePassword,
    required DeleteStaffUseCase deleteStaff,
  }) : _getStaff = getStaff,
       _createStaff = createStaff,
       _changeRole = changeRole,
       _changePassword = changePassword,
       _deleteStaff = deleteStaff,
       super(const StaffState.initial());

  Future<void> loadStaff() async {
    emit(const StaffState.loading());
    final result = await _getStaff();
    result.fold(
      (failure) => emit(StaffState.failure(failure)),
      (items) => emit(StaffState.loaded(items: items)),
    );
  }

  Future<void> createStaff({
    required String username,
    required String password,
    required StaffRole role,
  }) async {
    final currentItems = state.whenOrNull(loaded: (items) => items);
    emit(const StaffState.loading());
    final result = await _createStaff(
      username: username,
      password: password,
      role: role,
    );
    result.fold(
      (failure) => _emitMutationFailure(failure, currentItems),
      (_) => loadStaff(),
    );
  }

  Future<void> changeRole({
    required String uid,
    required StaffRole role,
  }) async {
    final currentItems = state.whenOrNull(loaded: (items) => items);
    emit(const StaffState.loading());
    final result = await _changeRole(uid: uid, role: role);
    result.fold(
      (failure) => _emitMutationFailure(failure, currentItems),
      (_) => loadStaff(),
    );
  }

  Future<void> changePassword({
    required String uid,
    required String newPassword,
  }) async {
    final currentItems = state.whenOrNull(loaded: (items) => items);
    emit(const StaffState.loading());
    final result = await _changePassword(uid: uid, newPassword: newPassword);
    result.fold(
      (failure) => _emitMutationFailure(failure, currentItems),
      (_) => loadStaff(),
    );
  }

  Future<void> deleteStaff(String uid) async {
    final currentItems = state.whenOrNull(loaded: (items) => items);
    if (currentItems == null) return;

    emit(const StaffState.loading());
    final result = await _deleteStaff(uid: uid, currentStaff: currentItems);
    result.fold(
      (failure) => _emitMutationFailure(failure, currentItems),
      (_) => loadStaff(),
    );
  }

  void _emitMutationFailure(ServerFailure failure, List<StaffListItem>? currentItems) {
    if (currentItems != null) {
      emit(StaffState.mutationFailure(failure: failure, items: currentItems));
    } else {
      emit(StaffState.failure(failure));
    }
  }
}
