import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/shared_feature/data/models/product_model.dart';
import 'package:proper_store/features/home/data/models/home_collection_banner_model.dart';
import 'package:proper_store/features/home/domain/use_cases/get_home_offer_card_use_case.dart';
import 'package:proper_store/features/home/domain/use_cases/get_most_sold_product_use_case.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetMainCollectionBannerDataUseCase mainCollectionBannerDataUseCase;
  final GetMostSoldProductUseCase getMostSoldProductUseCase;
  HomeCubit({
    required this.mainCollectionBannerDataUseCase,
    required this.getMostSoldProductUseCase,
  }) : super(HomeState());

  Future<void> getMainCollectionBannerData() async {
    emit(state.copyWith(bannerState: HomeStates.loading));
    final response = await mainCollectionBannerDataUseCase.call();
    if (!isClosed) {
      response.fold(
        (serverFailure) => emit(
          state.copyWith(
            failureCode: serverFailure.code,
            bannerState: HomeStates.failure,
          ),
        ),
        (data) => emit(
          state.copyWith(
            homeCollectionBannerModel: data,
            bannerState: HomeStates.success,
          ),
        ),
      );
    }
  }

  Future<void> getMostSoldProducts() async {
    emit(state.copyWith(productsState: HomeStates.loading));
    final response = await getMostSoldProductUseCase.call();

    if (!isClosed) {
      response.fold(
        (serverFailure) => emit(
          state.copyWith(
            failureCode: serverFailure.code,
            productsState: HomeStates.failure,
          ),
        ),
        (productsList) => emit(
          state.copyWith(
            mostSoldProductsList: productsList,
            productsState: HomeStates.success,
          ),
        ),
      );
    }
  }
}
