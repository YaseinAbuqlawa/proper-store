import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';
import 'package:proper_store/features/home/domain/repo/home_repo.dart';

@lazySingleton
class GetMainCollectionBannerDataUseCase {
  final HomeRepo repo;

  GetMainCollectionBannerDataUseCase({required this.repo});

  Future<Either<ServerFailure, HomeCollectionBannerModel>> call() async {
    return await repo.getMainCollectionBannerData();
  }
}
