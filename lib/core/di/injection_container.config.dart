// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:proper_store/core/di/injection_container.dart' as _i180;
import 'package:proper_store/core/products/data/data_sources/products_remote_data_source.dart'
    as _i122;
import 'package:proper_store/core/products/data/repo/products_repo_impl.dart'
    as _i614;
import 'package:proper_store/core/products/domain/repo/products_repo.dart'
    as _i1061;
import 'package:proper_store/core/products/domain/use_cases/get_all_products_use_case.dart'
    as _i714;
import 'package:proper_store/core/products/domain/use_cases/get_product_with_id_use_case.dart'
    as _i1033;
import 'package:proper_store/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i426;
import 'package:proper_store/features/auth/data/repo/auth_repo_impl.dart'
    as _i223;
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart' as _i396;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_anonymously_use_case.dart'
    as _i932;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_facebook_use_case.dart'
    as _i686;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_google_use_case.dart'
    as _i823;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_phone_number_use_case.dart'
    as _i1039;
import 'package:proper_store/features/auth/features/phone_auth_screen_presentation/cubit/phone_auth_cubit.dart'
    as _i501;
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/welcome_screen_cubit.dart'
    as _i628;
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart'
    as _i1006;
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
    gh.factory<_i1006.CartCubit>(() => _i1006.CartCubit());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => externalModules.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => externalModules.auth);
    gh.lazySingleton<_i809.FirebaseFunctions>(() => externalModules.functions);
    gh.lazySingleton<_i122.ProductsRemoteDataSource>(
      () => _i122.ProductsRemoteDataSource(
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
    gh.lazySingleton<_i1061.ProductsRepo>(
      () => _i614.ProductsRepoImpl(
        remoteDataSource: gh<_i122.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i714.GetAllProductsUseCase>(
      () => _i714.GetAllProductsUseCase(repo: gh<_i1061.ProductsRepo>()),
    );
    gh.lazySingleton<_i1033.GetProductWithIdUseCase>(
      () => _i1033.GetProductWithIdUseCase(repo: gh<_i1061.ProductsRepo>()),
    );
    gh.lazySingleton<_i426.AuthRemoteDataSource>(
      () => _i426.AuthRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        auth: gh<_i59.FirebaseAuth>(),
        functions: gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i66.GetRelatedProductsUseCase>(
      () =>
          _i66.GetRelatedProductsUseCase(repo: gh<_i1064.ProductDetailsRepo>()),
    );
    gh.lazySingleton<_i147.HomeRepo>(
      () => _i697.HomeRepoImpl(
        homeDataSource: gh<_i384.HomeRemoteDataSource>(),
        productsRemoteDataSource: gh<_i122.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i396.AuthRepo>(
      () => _i223.AuthRepoImpl(
        remoteDataSource: gh<_i426.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i846.ProductDetailsCubit>(
      () => _i846.ProductDetailsCubit(
        getProductWithIdUseCase: gh<_i1033.GetProductWithIdUseCase>(),
        getRelatedProductsUseCase: gh<_i66.GetRelatedProductsUseCase>(),
      ),
    );
    gh.lazySingleton<_i932.SignInAnonymouslyUseCase>(
      () => _i932.SignInAnonymouslyUseCase(repo: gh<_i396.AuthRepo>()),
    );
    gh.lazySingleton<_i686.SignInWithFacebookUseCase>(
      () => _i686.SignInWithFacebookUseCase(repo: gh<_i396.AuthRepo>()),
    );
    gh.lazySingleton<_i823.SignInWithGoogleUseCase>(
      () => _i823.SignInWithGoogleUseCase(repo: gh<_i396.AuthRepo>()),
    );
    gh.lazySingleton<_i1039.SignInWithPhoneNumberUseCase>(
      () => _i1039.SignInWithPhoneNumberUseCase(repo: gh<_i396.AuthRepo>()),
    );
    gh.lazySingleton<_i683.GetMainCollectionBannerDataUseCase>(
      () =>
          _i683.GetMainCollectionBannerDataUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.lazySingleton<_i71.GetMostSoldProductUseCase>(
      () => _i71.GetMostSoldProductUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.factory<_i628.WelcomeScreenCubit>(
      () => _i628.WelcomeScreenCubit(
        signInWithFacebookUseCase: gh<_i686.SignInWithFacebookUseCase>(),
        signInWithGoogleUseCase: gh<_i823.SignInWithGoogleUseCase>(),
        signInAnonymouslyUseCase: gh<_i932.SignInAnonymouslyUseCase>(),
      ),
    );
    gh.factory<_i501.PhoneAuthCubit>(
      () => _i501.PhoneAuthCubit(
        signInWithPhoneNumberUseCase: gh<_i1039.SignInWithPhoneNumberUseCase>(),
      ),
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
