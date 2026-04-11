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
import 'package:admin/features/auth/domain/use_cases/get_current_user_use_case.dart'
    as _i214;
import 'package:admin/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i482;
import 'package:admin/features/auth/domain/use_cases/sign_out_use_case.dart'
    as _i868;
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart'
    as _i469;
import 'package:admin/features/customers/data/data_sources/customers_remote_data_source.dart'
    as _i213;
import 'package:admin/features/customers/data/repo/customers_repo_impl.dart'
    as _i165;
import 'package:admin/features/customers/domain/repo/customers_repo.dart'
    as _i1026;
import 'package:admin/features/customers/domain/use_cases/get_customers_use_case.dart'
    as _i329;
import 'package:admin/features/customers/presentation/cubit/customer_favorites_cubit.dart'
    as _i315;
import 'package:admin/features/customers/presentation/cubit/customers_cubit.dart'
    as _i938;
import 'package:admin/features/orders/data/data_sources/orders_remote_data_source.dart'
    as _i837;
import 'package:admin/features/orders/data/repo/orders_repo_impl.dart' as _i424;
import 'package:admin/features/orders/domain/repo/orders_repo.dart' as _i978;
import 'package:admin/features/orders/domain/use_cases/get_customer_use_case.dart'
    as _i40;
import 'package:admin/features/orders/domain/use_cases/get_orders_use_case.dart'
    as _i447;
import 'package:admin/features/orders/domain/use_cases/update_order_status_use_case.dart'
    as _i300;
import 'package:admin/features/orders/presentation/cubit/order_details_cubit.dart'
    as _i707;
import 'package:admin/features/orders/presentation/cubit/orders_cubit.dart'
    as _i84;
import 'package:admin/features/products/data/data_sources/products_remote_data_source.dart'
    as _i442;
import 'package:admin/features/products/data/repo/products_repo_impl.dart'
    as _i721;
import 'package:admin/features/products/domain/repo/products_repo.dart'
    as _i229;
import 'package:admin/features/products/domain/use_cases/add_category_use_case.dart'
    as _i531;
import 'package:admin/features/products/domain/use_cases/delete_product_use_case.dart'
    as _i836;
import 'package:admin/features/products/domain/use_cases/get_all_products_use_case.dart'
    as _i72;
import 'package:admin/features/products/domain/use_cases/get_categories_use_case.dart'
    as _i436;
import 'package:admin/features/products/domain/use_cases/get_products_by_ids_use_case.dart'
    as _i359;
import 'package:admin/features/products/domain/use_cases/save_product_use_case.dart'
    as _i717;
import 'package:admin/features/products/domain/use_cases/upload_color_image_use_case.dart'
    as _i938;
import 'package:admin/features/products/domain/use_cases/upload_product_main_image_use_case.dart'
    as _i604;
import 'package:admin/features/products/presentation/cubit/categories_cubit.dart'
    as _i293;
import 'package:admin/features/products/presentation/cubit/product_form_cubit.dart'
    as _i593;
import 'package:admin/features/products/presentation/cubit/product_form_data_cubit.dart'
    as _i902;
import 'package:admin/features/products/presentation/cubit/products_cubit.dart'
    as _i177;
import 'package:admin/features/reports/data/data_sources/reports_remote_data_source.dart'
    as _i754;
import 'package:admin/features/reports/data/repo/reports_repo_impl.dart'
    as _i189;
import 'package:admin/features/reports/domain/repo/reports_repo.dart' as _i922;
import 'package:admin/features/reports/domain/use_cases/get_dashboard_stats_use_case.dart'
    as _i25;
import 'package:admin/features/reports/domain/use_cases/get_out_of_stock_products_use_case.dart'
    as _i145;
import 'package:admin/features/reports/presentation/cubit/reports_cubit.dart'
    as _i267;
import 'package:admin/features/staff/data/data_sources/staff_remote_data_source.dart'
    as _i499;
import 'package:admin/features/staff/data/repo/staff_repo_impl.dart' as _i662;
import 'package:admin/features/staff/domain/repo/staff_repo.dart' as _i309;
import 'package:admin/features/staff/domain/use_cases/change_password_use_case.dart'
    as _i1013;
import 'package:admin/features/staff/domain/use_cases/change_role_use_case.dart'
    as _i760;
import 'package:admin/features/staff/domain/use_cases/create_staff_use_case.dart'
    as _i590;
import 'package:admin/features/staff/domain/use_cases/delete_staff_use_case.dart'
    as _i443;
import 'package:admin/features/staff/domain/use_cases/get_staff_use_case.dart'
    as _i616;
import 'package:admin/features/staff/presentation/cubit/staff_cubit.dart'
    as _i79;
import 'package:admin/features/store_config/data/data_sources/store_config_remote_data_source.dart'
    as _i883;
import 'package:admin/features/store_config/data/repo/store_config_repo_impl.dart'
    as _i37;
import 'package:admin/features/store_config/domain/repo/store_config_repo.dart'
    as _i1053;
import 'package:admin/features/store_config/domain/use_cases/add_category_use_case.dart'
    as _i839;
import 'package:admin/features/store_config/domain/use_cases/delete_category_use_case.dart'
    as _i483;
import 'package:admin/features/store_config/domain/use_cases/get_store_config_use_case.dart'
    as _i30;
import 'package:admin/features/store_config/domain/use_cases/update_collection_banner_use_case.dart'
    as _i214;
import 'package:admin/features/store_config/domain/use_cases/update_shipping_costs_use_case.dart'
    as _i252;
import 'package:admin/features/store_config/presentation/cubit/store_config_cubit.dart'
    as _i625;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
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
    gh.factory<_i902.ProductFormDataCubit>(() => _i902.ProductFormDataCubit());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => externalModules.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => externalModules.auth);
    gh.lazySingleton<_i457.FirebaseStorage>(() => externalModules.storage);
    gh.lazySingleton<_i809.FirebaseFunctions>(() => externalModules.functions);
    gh.lazySingleton<_i837.OrdersRemoteDataSource>(
      () => _i837.OrdersRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        functions: gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i499.StaffRemoteDataSource>(
      () => _i499.StaffRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        functions: gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i309.StaffRepo>(
      () => _i662.StaffRepoImpl(dataSource: gh<_i499.StaffRemoteDataSource>()),
    );
    gh.factory<_i1013.ChangePasswordUseCase>(
      () => _i1013.ChangePasswordUseCase(repo: gh<_i309.StaffRepo>()),
    );
    gh.factory<_i760.ChangeRoleUseCase>(
      () => _i760.ChangeRoleUseCase(repo: gh<_i309.StaffRepo>()),
    );
    gh.factory<_i590.CreateStaffUseCase>(
      () => _i590.CreateStaffUseCase(repo: gh<_i309.StaffRepo>()),
    );
    gh.factory<_i443.DeleteStaffUseCase>(
      () => _i443.DeleteStaffUseCase(repo: gh<_i309.StaffRepo>()),
    );
    gh.factory<_i616.GetStaffUseCase>(
      () => _i616.GetStaffUseCase(repo: gh<_i309.StaffRepo>()),
    );
    gh.lazySingleton<_i213.CustomersRemoteDataSource>(
      () => _i213.CustomersRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i754.ReportsRemoteDataSource>(
      () => _i754.ReportsRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i442.ProductsRemoteDataSource>(
      () => _i442.ProductsRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        storage: gh<_i457.FirebaseStorage>(),
      ),
    );
    gh.lazySingleton<_i883.StoreConfigRemoteDataSource>(
      () => _i883.StoreConfigRemoteDataSource(
        firestore: gh<_i974.FirebaseFirestore>(),
        storage: gh<_i457.FirebaseStorage>(),
      ),
    );
    gh.lazySingleton<_i978.OrdersRepo>(
      () =>
          _i424.OrdersRepoImpl(dataSource: gh<_i837.OrdersRemoteDataSource>()),
    );
    gh.lazySingleton<_i529.AuthRemoteDataSource>(
      () => _i529.AuthRemoteDataSource(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i229.ProductsRepo>(
      () => _i721.ProductsRepoImpl(
        dataSource: gh<_i442.ProductsRemoteDataSource>(),
      ),
    );
    gh.factory<_i79.StaffCubit>(
      () => _i79.StaffCubit(
        getStaff: gh<_i616.GetStaffUseCase>(),
        createStaff: gh<_i590.CreateStaffUseCase>(),
        changeRole: gh<_i760.ChangeRoleUseCase>(),
        changePassword: gh<_i1013.ChangePasswordUseCase>(),
        deleteStaff: gh<_i443.DeleteStaffUseCase>(),
      ),
    );
    gh.lazySingleton<_i1026.CustomersRepo>(
      () => _i165.CustomersRepoImpl(
        dataSource: gh<_i213.CustomersRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i531.AddCategoryUseCase>(
      () => _i531.AddCategoryUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i836.DeleteProductUseCase>(
      () => _i836.DeleteProductUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i72.GetAllProductsUseCase>(
      () => _i72.GetAllProductsUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i436.GetCategoriesUseCase>(
      () => _i436.GetCategoriesUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i359.GetProductsByIdsUseCase>(
      () => _i359.GetProductsByIdsUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i938.UploadColorImageUseCase>(
      () => _i938.UploadColorImageUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i604.UploadProductMainImageUseCase>(
      () => _i604.UploadProductMainImageUseCase(repo: gh<_i229.ProductsRepo>()),
    );
    gh.lazySingleton<_i745.AuthRepo>(
      () => _i1072.AuthRepoImpl(dataSource: gh<_i529.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i717.SaveProductUseCase>(
      () => _i717.SaveProductUseCase(
        repo: gh<_i229.ProductsRepo>(),
        uploadColorImageUseCase: gh<_i938.UploadColorImageUseCase>(),
        uploadProductMainImageUseCase:
            gh<_i604.UploadProductMainImageUseCase>(),
      ),
    );
    gh.factory<_i177.ProductsCubit>(
      () => _i177.ProductsCubit(
        getAllProductsUseCase: gh<_i72.GetAllProductsUseCase>(),
        deleteProductUseCase: gh<_i836.DeleteProductUseCase>(),
      ),
    );
    gh.lazySingleton<_i922.ReportsRepo>(
      () => _i189.ReportsRepoImpl(
        dataSource: gh<_i754.ReportsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1053.StoreConfigRepo>(
      () => _i37.StoreConfigRepoImpl(gh<_i883.StoreConfigRemoteDataSource>()),
    );
    gh.lazySingleton<_i329.GetCustomersUseCase>(
      () => _i329.GetCustomersUseCase(repo: gh<_i1026.CustomersRepo>()),
    );
    gh.lazySingleton<_i40.GetCustomerUseCase>(
      () => _i40.GetCustomerUseCase(repo: gh<_i978.OrdersRepo>()),
    );
    gh.lazySingleton<_i447.GetOrdersUseCase>(
      () => _i447.GetOrdersUseCase(repo: gh<_i978.OrdersRepo>()),
    );
    gh.lazySingleton<_i300.UpdateOrderStatusUseCase>(
      () => _i300.UpdateOrderStatusUseCase(repo: gh<_i978.OrdersRepo>()),
    );
    gh.lazySingleton<_i839.AddCategoryUseCase>(
      () => _i839.AddCategoryUseCase(gh<_i1053.StoreConfigRepo>()),
    );
    gh.lazySingleton<_i483.DeleteCategoryUseCase>(
      () => _i483.DeleteCategoryUseCase(gh<_i1053.StoreConfigRepo>()),
    );
    gh.lazySingleton<_i30.GetStoreConfigUseCase>(
      () => _i30.GetStoreConfigUseCase(gh<_i1053.StoreConfigRepo>()),
    );
    gh.lazySingleton<_i214.UpdateCollectionBannerUseCase>(
      () => _i214.UpdateCollectionBannerUseCase(gh<_i1053.StoreConfigRepo>()),
    );
    gh.lazySingleton<_i252.UpdateShippingCostsUseCase>(
      () => _i252.UpdateShippingCostsUseCase(gh<_i1053.StoreConfigRepo>()),
    );
    gh.factory<_i938.CustomersCubit>(
      () => _i938.CustomersCubit(
        getCustomersUseCase: gh<_i329.GetCustomersUseCase>(),
      ),
    );
    gh.factory<_i707.OrderDetailsCubit>(
      () => _i707.OrderDetailsCubit(
        getCustomerUseCase: gh<_i40.GetCustomerUseCase>(),
        updateOrderStatusUseCase: gh<_i300.UpdateOrderStatusUseCase>(),
      ),
    );
    gh.factory<_i315.CustomerFavoritesCubit>(
      () => _i315.CustomerFavoritesCubit(
        getProductsByIds: gh<_i359.GetProductsByIdsUseCase>(),
      ),
    );
    gh.factory<_i625.StoreConfigCubit>(
      () => _i625.StoreConfigCubit(
        getStoreConfig: gh<_i30.GetStoreConfigUseCase>(),
        updateShippingCosts: gh<_i252.UpdateShippingCostsUseCase>(),
        addCategory: gh<_i839.AddCategoryUseCase>(),
        deleteCategory: gh<_i483.DeleteCategoryUseCase>(),
        updateBanner: gh<_i214.UpdateCollectionBannerUseCase>(),
      ),
    );
    gh.lazySingleton<_i214.GetCurrentUserUseCase>(
      () => _i214.GetCurrentUserUseCase(repo: gh<_i745.AuthRepo>()),
    );
    gh.lazySingleton<_i482.SignInUseCase>(
      () => _i482.SignInUseCase(repo: gh<_i745.AuthRepo>()),
    );
    gh.lazySingleton<_i868.SignOutUseCase>(
      () => _i868.SignOutUseCase(repo: gh<_i745.AuthRepo>()),
    );
    gh.factory<_i293.CategoriesCubit>(
      () => _i293.CategoriesCubit(
        getCategoriesUseCase: gh<_i436.GetCategoriesUseCase>(),
        addCategoryUseCase: gh<_i531.AddCategoryUseCase>(),
      ),
    );
    gh.factory<_i593.ProductFormCubit>(
      () => _i593.ProductFormCubit(
        saveProductUseCase: gh<_i717.SaveProductUseCase>(),
      ),
    );
    gh.factory<_i25.GetDashboardStatsUseCase>(
      () => _i25.GetDashboardStatsUseCase(repo: gh<_i922.ReportsRepo>()),
    );
    gh.factory<_i145.GetOutOfStockProductsUseCase>(
      () => _i145.GetOutOfStockProductsUseCase(repo: gh<_i922.ReportsRepo>()),
    );
    gh.factory<_i84.OrdersCubit>(
      () => _i84.OrdersCubit(
        getOrdersUseCase: gh<_i447.GetOrdersUseCase>(),
        updateOrderStatusUseCase: gh<_i300.UpdateOrderStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i469.AuthCubit>(
      () => _i469.AuthCubit(
        signInUseCase: gh<_i482.SignInUseCase>(),
        signOutUseCase: gh<_i868.SignOutUseCase>(),
        getCurrentUserUseCase: gh<_i214.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i267.ReportsCubit>(
      () => _i267.ReportsCubit(
        getDashboardStatsUseCase: gh<_i25.GetDashboardStatsUseCase>(),
        getOutOfStockProductsUseCase: gh<_i145.GetOutOfStockProductsUseCase>(),
      ),
    );
    return this;
  }
}

class _$ExternalModules extends _i600.ExternalModules {}
