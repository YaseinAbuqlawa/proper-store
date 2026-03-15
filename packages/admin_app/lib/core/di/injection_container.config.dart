// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/core/di/injection_container.dart' as _i600;
import 'package:admin/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i529;
import 'package:admin/features/auth/data/repo/auth_repo_impl.dart' as _i1072;
import 'package:admin/features/auth/domain/repo/auth_repo.dart' as _i745;
import 'package:admin/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i482;
import 'package:admin/features/auth/domain/use_cases/sign_out_use_case.dart'
    as _i868;
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart'
    as _i469;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalModules = _$ExternalModules();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => externalModules.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => externalModules.auth);
    gh.lazySingleton<_i529.AuthRemoteDataSource>(
      () => _i529.AuthRemoteDataSource(
        auth: gh<_i59.FirebaseAuth>(),
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i745.AuthRepo>(
      () => _i1072.AuthRepoImpl(dataSource: gh<_i529.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i482.SignInUseCase>(
      () => _i482.SignInUseCase(repo: gh<_i745.AuthRepo>()),
    );
    gh.lazySingleton<_i868.SignOutUseCase>(
      () => _i868.SignOutUseCase(repo: gh<_i745.AuthRepo>()),
    );
    gh.lazySingleton<_i469.AuthCubit>(
      () => _i469.AuthCubit(
        signInUseCase: gh<_i482.SignInUseCase>(),
        signOutUseCase: gh<_i868.SignOutUseCase>(),
      ),
    );
    return this;
  }
}

class _$ExternalModules extends _i600.ExternalModules {}
