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
import 'package:proper_store/core/products/domain/use_cases/get_products_by_category_use_case.dart'
    as _i869;
import 'package:proper_store/core/services/auth_orchestration_service.dart'
    as _i47;
import 'package:proper_store/features/addresses/data/data_sources/addresses_remote_data_source.dart'
    as _i472;
import 'package:proper_store/features/addresses/data/repo/addresses_repo_impl.dart'
    as _i720;
import 'package:proper_store/features/addresses/domain/repo/addresses_repo.dart'
    as _i979;
import 'package:proper_store/features/addresses/domain/use_cases/add_address_use_case.dart'
    as _i268;
import 'package:proper_store/features/addresses/domain/use_cases/delete_address_use_case.dart'
    as _i880;
import 'package:proper_store/features/addresses/domain/use_cases/get_addresses_use_case.dart'
    as _i1013;
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart'
    as _i1010;
import 'package:proper_store/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i426;
import 'package:proper_store/features/auth/data/repo/auth_repo_impl.dart'
    as _i223;
import 'package:proper_store/features/auth/domain/repo/auth_repo.dart' as _i396;
import 'package:proper_store/features/auth/domain/use_cases/resume_facebook_redirect_use_case.dart'
    as _i795;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_anonymously_use_case.dart'
    as _i932;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_facebook_use_case.dart'
    as _i686;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_google_use_case.dart'
    as _i823;
import 'package:proper_store/features/auth/domain/use_cases/sign_in_with_phone_number_use_case.dart'
    as _i1039;
import 'package:proper_store/features/auth/domain/use_cases/sign_out_use_case.dart'
    as _i128;
import 'package:proper_store/features/auth/features/phone_auth_screen_presentation/cubit/phone_auth_cubit.dart'
    as _i501;
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart'
    as _i967;
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart'
    as _i1006;
import 'package:proper_store/features/checkout/data/data_sources/shipping_cost_remote_data_source.dart'
    as _i380;
import 'package:proper_store/features/checkout/data/repo/shipping_cost_repo_impl.dart'
    as _i1001;
import 'package:proper_store/features/checkout/domain/repo/shipping_cost_repo.dart'
    as _i579;
import 'package:proper_store/features/checkout/domain/use_cases/get_shipping_cost_use_case.dart'
    as _i890;
import 'package:proper_store/features/checkout/presentation/cubit/checkout_cubit.dart'
    as _i541;
import 'package:proper_store/features/favorites/data/data_source/favorites_remote_data_source.dart'
    as _i662;
import 'package:proper_store/features/favorites/data/repo/favorites_repo_impl.dart'
    as _i1071;
import 'package:proper_store/features/favorites/domain/repo/favorites_repo.dart'
    as _i206;
import 'package:proper_store/features/favorites/domain/use_cases/get_favorite_products_use_case.dart'
    as _i182;
import 'package:proper_store/features/favorites/domain/use_cases/set_customer_favorites_use_case.dart'
    as _i726;
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart'
    as _i395;
import 'package:proper_store/features/home/data/data_sources/home_remote_data_source.dart'
    as _i384;
import 'package:proper_store/features/home/data/repo/home_repo_impl.dart'
    as _i697;
import 'package:proper_store/features/home/domain/repo/home_repo.dart' as _i147;
import 'package:proper_store/features/home/domain/use_cases/get_bag_categories_use_case.dart'
    as _i924;
import 'package:proper_store/features/home/domain/use_cases/get_home_offer_card_use_case.dart'
    as _i683;
import 'package:proper_store/features/home/domain/use_cases/get_most_sold_product_use_case.dart'
    as _i71;
import 'package:proper_store/features/home/presentation/cubit/home_cubit.dart'
    as _i1070;
import 'package:proper_store/features/orders/data/data_sources/orders_remote_data_source.dart'
    as _i766;
import 'package:proper_store/features/orders/data/repo/orders_repo_impl.dart'
    as _i308;
import 'package:proper_store/features/orders/domain/repo/orders_repo.dart'
    as _i333;
import 'package:proper_store/features/orders/domain/use_cases/create_order_use_case.dart'
    as _i347;
import 'package:proper_store/features/orders/domain/use_cases/get_customer_orders_use_case.dart'
    as _i39;
import 'package:proper_store/features/orders/presentation/cubit/orders_cubit.dart'
    as _i769;
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
import 'package:proper_store/features/products/presentation/cubit/products_screen_cubit.dart'
    as _i397;
import 'package:proper_store/features/profile/data/data_source/profile_remote_data_source.dart'
    as _i360;
import 'package:proper_store/features/profile/data/repo/profile_repo_impl.dart'
    as _i1070;
import 'package:proper_store/features/profile/domain/repo/profile_repo.dart'
    as _i871;
import 'package:proper_store/features/profile/domain/use_cases/get_customer_data_use_case.dart'
    as _i596;
import 'package:proper_store/features/profile/presentation/cubit/profile_cubit.dart'
    as _i443;

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
    gh.lazySingleton<_i809.FirebaseFunctions>(() => externalModules.functions);
    gh.lazySingleton<_i1006.CartCubit>(() => _i1006.CartCubit());
    gh.lazySingleton<_i360.ProfileRemoteDataSource>(
      () => _i360.ProfileRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i871.ProfileRepo>(
      () => _i1070.ProfileRepoImpl(
        remoteDataSource: gh<_i360.ProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i122.ProductsRemoteDataSource>(
      () => _i122.ProductsRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i472.AddressesRemoteDataSource>(
      () => _i472.AddressesRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i380.ShippingCostRemoteDataSource>(
      () => _i380.ShippingCostRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i662.FavoritesRemoteDataSource>(
      () => _i662.FavoritesRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i384.HomeRemoteDataSource>(
      () =>
          _i384.HomeRemoteDataSource(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i766.OrdersRemoteDataSource>(
      () => _i766.OrdersRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
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
    gh.lazySingleton<_i579.ShippingCostRepo>(
      () => _i1001.ShippingCostRepoImpl(
        remoteDataSource: gh<_i380.ShippingCostRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i714.GetAllProductsUseCase>(
      () => _i714.GetAllProductsUseCase(repo: gh<_i1061.ProductsRepo>()),
    );
    gh.lazySingleton<_i1033.GetProductWithIdUseCase>(
      () => _i1033.GetProductWithIdUseCase(repo: gh<_i1061.ProductsRepo>()),
    );
    gh.lazySingleton<_i869.GetProductsByCategoryUseCase>(
      () => _i869.GetProductsByCategoryUseCase(repo: gh<_i1061.ProductsRepo>()),
    );
    gh.lazySingleton<_i426.AuthRemoteDataSource>(
      () => _i426.AuthRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        auth: gh<_i59.FirebaseAuth>(),
        functions: gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.factory<_i397.ProductsScreenCubit>(
      () => _i397.ProductsScreenCubit(
        getAllProductsUseCase: gh<_i714.GetAllProductsUseCase>(),
        getProductsByCategoryUseCase: gh<_i869.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.lazySingleton<_i596.GetCustomerDataUseCase>(
      () => _i596.GetCustomerDataUseCase(repo: gh<_i871.ProfileRepo>()),
    );
    gh.lazySingleton<_i979.AddressesRepo>(
      () => _i720.AddressesRepoImpl(
        remoteDataSource: gh<_i472.AddressesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i66.GetRelatedProductsUseCase>(
      () =>
          _i66.GetRelatedProductsUseCase(repo: gh<_i1064.ProductDetailsRepo>()),
    );
    gh.lazySingleton<_i206.FavoritesRepo>(
      () => _i1071.FavoritesRepoImpl(
        remoteDataSource: gh<_i662.FavoritesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i333.OrdersRepo>(
      () => _i308.OrdersRepoImpl(
        remoteDataSource: gh<_i766.OrdersRemoteDataSource>(),
      ),
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
    gh.lazySingleton<_i890.GetShippingCostUseCase>(
      () => _i890.GetShippingCostUseCase(repo: gh<_i579.ShippingCostRepo>()),
    );
    gh.lazySingleton<_i268.AddAddressUseCase>(
      () => _i268.AddAddressUseCase(repo: gh<_i979.AddressesRepo>()),
    );
    gh.lazySingleton<_i880.DeleteAddressUseCase>(
      () => _i880.DeleteAddressUseCase(repo: gh<_i979.AddressesRepo>()),
    );
    gh.lazySingleton<_i1013.GetAddressesUseCase>(
      () => _i1013.GetAddressesUseCase(repo: gh<_i979.AddressesRepo>()),
    );
    gh.lazySingleton<_i182.GetFavoriteProductsUseCase>(
      () => _i182.GetFavoriteProductsUseCase(repo: gh<_i206.FavoritesRepo>()),
    );
    gh.lazySingleton<_i726.SetCustomerFavoritesUseCase>(
      () => _i726.SetCustomerFavoritesUseCase(repo: gh<_i206.FavoritesRepo>()),
    );
    gh.factory<_i846.ProductDetailsCubit>(
      () => _i846.ProductDetailsCubit(
        getProductWithIdUseCase: gh<_i1033.GetProductWithIdUseCase>(),
        getRelatedProductsUseCase: gh<_i66.GetRelatedProductsUseCase>(),
      ),
    );
    gh.lazySingleton<_i395.FavoritesCubit>(
      () => _i395.FavoritesCubit(
        setCustomerFavoritesUseCase: gh<_i726.SetCustomerFavoritesUseCase>(),
        getFavoriteProductsUseCase: gh<_i182.GetFavoriteProductsUseCase>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i795.ResumeFacebookRedirectUseCase>(
      () => _i795.ResumeFacebookRedirectUseCase(repo: gh<_i396.AuthRepo>()),
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
    gh.lazySingleton<_i128.SignOutUseCase>(
      () => _i128.SignOutUseCase(repo: gh<_i396.AuthRepo>()),
    );
    gh.lazySingleton<_i924.GetBagCategoriesUseCase>(
      () => _i924.GetBagCategoriesUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.lazySingleton<_i683.GetMainCollectionBannerDataUseCase>(
      () =>
          _i683.GetMainCollectionBannerDataUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.lazySingleton<_i71.GetMostSoldProductUseCase>(
      () => _i71.GetMostSoldProductUseCase(repo: gh<_i147.HomeRepo>()),
    );
    gh.lazySingleton<_i347.CreateOrderUseCase>(
      () => _i347.CreateOrderUseCase(repo: gh<_i333.OrdersRepo>()),
    );
    gh.lazySingleton<_i39.GetCustomerOrdersUseCase>(
      () => _i39.GetCustomerOrdersUseCase(repo: gh<_i333.OrdersRepo>()),
    );
    gh.lazySingleton<_i1010.AddressesCubit>(
      () => _i1010.AddressesCubit(
        getAddressesUseCase: gh<_i1013.GetAddressesUseCase>(),
        addAddressUseCase: gh<_i268.AddAddressUseCase>(),
        deleteAddressUseCase: gh<_i880.DeleteAddressUseCase>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i967.AuthCubit>(
      () => _i967.AuthCubit(
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
        getBagCategoriesUseCase: gh<_i924.GetBagCategoriesUseCase>(),
        mainCollectionBannerDataUseCase:
            gh<_i683.GetMainCollectionBannerDataUseCase>(),
        getMostSoldProductUseCase: gh<_i71.GetMostSoldProductUseCase>(),
      ),
    );
    gh.factory<_i541.CheckoutCubit>(
      () => _i541.CheckoutCubit(
        createOrderUseCase: gh<_i347.CreateOrderUseCase>(),
        getShippingCostUseCase: gh<_i890.GetShippingCostUseCase>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i443.ProfileCubit>(
      () => _i443.ProfileCubit(
        getCustomerDataUseCase: gh<_i596.GetCustomerDataUseCase>(),
        signOutUseCase: gh<_i128.SignOutUseCase>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i769.OrdersCubit>(
      () => _i769.OrdersCubit(
        getCustomerOrdersUseCase: gh<_i39.GetCustomerOrdersUseCase>(),
        createOrderUseCase: gh<_i347.CreateOrderUseCase>(),
        auth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i47.AuthOrchestrationService>(
      () => _i47.AuthOrchestrationService(
        auth: gh<_i59.FirebaseAuth>(),
        profileCubit: gh<_i443.ProfileCubit>(),
        favoritesCubit: gh<_i395.FavoritesCubit>(),
        cartCubit: gh<_i1006.CartCubit>(),
        resumeFacebookRedirect: gh<_i795.ResumeFacebookRedirectUseCase>(),
      ),
    );
    return this;
  }
}

class _$ExternalModules extends _i180.ExternalModules {}
