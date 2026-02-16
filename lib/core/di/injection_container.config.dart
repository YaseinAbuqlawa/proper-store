// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:proper_store/core/di/injection_container.dart' as _i180;
import 'package:proper_store/core/shared_feature/data/data_sources/products_remote_data_source.dart'
    as _i435;
import 'package:proper_store/core/shared_feature/data/repo/products_repo_impl.dart'
    as _i449;
import 'package:proper_store/core/shared_feature/domain/repo/products_repo.dart'
    as _i126;
import 'package:proper_store/core/shared_feature/domain/use_cases/get_product_with_id_use_case.dart'
    as _i927;
import 'package:proper_store/features/home/data/data_sources/home_remote_data_source.dart'
    as _i384;
import 'package:proper_store/features/home/data/repo/home_repo_impl.dart'
    as _i697;
import 'package:proper_store/features/home/domain/repo/home_repo.dart' as _i147;
import 'package:proper_store/features/home/domain/use_cases/get_home_offer_card_use_case.dart'
    as _i683;
import 'package:proper_store/features/home/domain/use_cases/get_most_sold_product_use_case.dart'
    as _i71;
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart'
    as _i1070;
import 'package:proper_store/features/product_details/data/data_srouces/product_details_remote_data_source.dart'
    as _i20;
import 'package:proper_store/features/product_details/data/repo/product_details_repo_impl.dart'
    as _i911;
import 'package:proper_store/features/product_details/domain/repo/product_details_repo.dart'
    as _i1064;
import 'package:proper_store/features/product_details/domain/use_cases/get_related_products_use_case.dart'
    as _i66;
import 'package:proper_store/features/product_details/presentation/cubit/product_details_cubit.dart'
    as _i846;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalModules = _$ExternalModules();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => externalModules.firestore);
    gh.lazySingleton<_i435.ProductsRemoteDataSource>(
      () => _i435.ProductsRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i384.HomeRemoteDataSource>(
      () =>
          _i384.HomeRemoteDataSource(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i20.ProductDetailsRemoteDataSource>(
      () => _i20.ProductDetailsRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i1064.ProductDetailsRepo>(
      () => _i911.ProductDetailsRepoImpl(
        remoteDataSource: gh<_i20.ProductDetailsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i126.ProductsRepo>(
      () => _i449.ProductsRepoImpl(
        remoteDataSource: gh<_i435.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i66.GetRelatedProductsUseCase>(
      () =>
          _i66.GetRelatedProductsUseCase(repo: gh<_i1064.ProductDetailsRepo>()),
    );
    gh.lazySingleton<_i147.HomeRepo>(
      () => _i697.HomeRepoImpl(
        homeDataSource: gh<_i384.HomeRemoteDataSource>(),
        productsRemoteDataSource: gh<_i435.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i927.GetProductWithIdUseCase>(
      () => _i927.GetProductWithIdUseCase(repo: gh<_i126.ProductsRepo>()),
    );
    gh.factory<_i846.ProductDetailsCubit>(
      () => _i846.ProductDetailsCubit(
        getProductWithIdUseCase: gh<_i927.GetProductWithIdUseCase>(),
        getRelatedProductsUseCase: gh<_i66.GetRelatedProductsUseCase>(),
      ),
    );
    gh.lazySingleton<_i683.GetMainCollectionBannerDataUseCase>(
      () =>
          _i683.GetMainCollectionBannerDataUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.lazySingleton<_i71.GetMostSoldProductUseCase>(
      () => _i71.GetMostSoldProductUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.factory<_i1070.HomeCubit>(
      () => _i1070.HomeCubit(
        mainCollectionBannerDataUseCase:
            gh<_i683.GetMainCollectionBannerDataUseCase>(),
        getMostSoldProductUseCase: gh<_i71.GetMostSoldProductUseCase>(),
      ),
    );
    return this;
  }
}

class _$ExternalModules extends _i180.ExternalModules {}
