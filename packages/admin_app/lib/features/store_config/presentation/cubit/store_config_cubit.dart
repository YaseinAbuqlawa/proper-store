import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:proper_store_shared/models/category_model.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

import 'package:admin/features/store_config/domain/use_cases/add_category_use_case.dart';
import 'package:admin/features/store_config/domain/use_cases/delete_category_use_case.dart';
import 'package:admin/features/store_config/domain/use_cases/get_store_config_use_case.dart';
import 'package:admin/features/store_config/domain/use_cases/update_collection_banner_use_case.dart';
import 'package:admin/features/store_config/domain/use_cases/update_shipping_costs_use_case.dart';

part 'store_config_cubit.freezed.dart';
part 'store_config_state.dart';

@injectable
class StoreConfigCubit extends Cubit<StoreConfigState> {
  final GetStoreConfigUseCase _getStoreConfig;
  final UpdateShippingCostsUseCase _updateShippingCosts;
  final AddCategoryUseCase _addCategory;
  final DeleteCategoryUseCase _deleteCategory;
  final UpdateCollectionBannerUseCase _updateBanner;

  StoreConfigCubit({
    required GetStoreConfigUseCase getStoreConfig,
    required UpdateShippingCostsUseCase updateShippingCosts,
    required AddCategoryUseCase addCategory,
    required DeleteCategoryUseCase deleteCategory,
    required UpdateCollectionBannerUseCase updateBanner,
  })  : _getStoreConfig = getStoreConfig,
        _updateShippingCosts = updateShippingCosts,
        _addCategory = addCategory,
        _deleteCategory = deleteCategory,
        _updateBanner = updateBanner,
        super(const StoreConfigState.initial());

  Future<void> loadAll() async {
    emit(const StoreConfigState.loading());
    final result = await _getStoreConfig();
    if (isClosed) return;
    result.fold(
      (failure) => emit(StoreConfigState.failure(message: failure.code)),
      (data) => emit(
        StoreConfigState.loaded(
          shippingCosts: data.shippingCosts,
          categories: data.categories,
          banner: data.banner,
        ),
      ),
    );
  }

  Future<bool> addShippingCost(String governorate, double cost) async {
    final loaded = _requireLoaded();
    if (loaded == null) return false;

    final updated = {...loaded.shippingCosts, governorate: cost};
    emit(loaded.copyWith(isSavingShipping: true));

    final result = await _updateShippingCosts(updated);
    if (isClosed) return false;

    return result.fold(
      (_) {
        emit(loaded.copyWith(isSavingShipping: false));
        return false;
      },
      (_) {
        emit(loaded.copyWith(shippingCosts: updated, isSavingShipping: false));
        return true;
      },
    );
  }

  Future<bool> deleteShippingCost(String governorate) async {
    final loaded = _requireLoaded();
    if (loaded == null) return false;

    final updated = Map<String, double>.from(loaded.shippingCosts)
      ..remove(governorate);
    emit(loaded.copyWith(isSavingShipping: true));

    final result = await _updateShippingCosts(updated);
    if (isClosed) return false;

    return result.fold(
      (_) {
        emit(loaded.copyWith(isSavingShipping: false));
        return false;
      },
      (_) {
        emit(loaded.copyWith(shippingCosts: updated, isSavingShipping: false));
        return true;
      },
    );
  }

  Future<bool> addCategory(String name, Uint8List rawBytes) async {
    final loaded = _requireLoaded();
    if (loaded == null) return false;

    emit(loaded.copyWith(isSavingCategory: true));

    final result = await _addCategory(name: name, imageBytes: rawBytes);
    if (isClosed) return false;

    return result.fold(
      (_) {
        emit(loaded.copyWith(isSavingCategory: false));
        return false;
      },
      (_) async {
        final categoriesResult = await _getStoreConfig();
        if (isClosed) return false;
        final categories = categoriesResult.fold(
          (_) => loaded.categories,
          (data) => data.categories,
        );
        emit(loaded.copyWith(categories: categories, isSavingCategory: false));
        return true;
      },
    );
  }

  Future<bool> deleteCategory(CategoryModel category) async {
    final loaded = _requireLoaded();
    if (loaded == null) return false;

    emit(loaded.copyWith(isSavingCategory: true));

    final result = await _deleteCategory(
      id: category.id,
      imageUrl: category.imageUrl,
    );
    if (isClosed) return false;

    return result.fold(
      (_) {
        emit(loaded.copyWith(isSavingCategory: false));
        return false;
      },
      (_) {
        final updated = loaded.categories
            .where((c) => c.id != category.id)
            .toList();
        emit(loaded.copyWith(categories: updated, isSavingCategory: false));
        return true;
      },
    );
  }

  Future<bool> saveBanner({
    required HomeCollectionBannerModel banner,
    Uint8List? newImageBytes,
  }) async {
    final loaded = _requireLoaded();
    if (loaded == null) return false;

    emit(loaded.copyWith(isSavingBanner: true));

    final result = await _updateBanner(
      banner: banner,
      newImageBytes: newImageBytes,
    );
    if (isClosed) return false;

    return result.fold(
      (_) {
        emit(loaded.copyWith(isSavingBanner: false));
        return false;
      },
      (_) {
        emit(loaded.copyWith(banner: banner, isSavingBanner: false));
        return true;
      },
    );
  }

  StoreConfigLoaded? _requireLoaded() {
    final s = state;
    if (s is StoreConfigLoaded) return s;
    return null;
  }
}
