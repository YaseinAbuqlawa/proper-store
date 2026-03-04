import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/features/home/data/models/category_model.dart';
import 'package:proper_store/features/home/data/models/home_collection_banner_model.dart';

@lazySingleton
class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource({required this.firestore});

  Future<HomeCollectionBannerModel> getMainCollectionBannerData() async {
    final offerCards = await firestore
        .collection(AppConsts.storeConfigCollection)
        .doc(AppConsts.storeConfigMainCollectionBannerDoc)
        .get();

    final firstCardData = (offerCards.data()!);

    return HomeCollectionBannerModel.fromJson(firstCardData);
  }

  Future<List<CategoryModel>> getBagCategories() async {
    final bagCategories = await firestore
        .collection(AppConsts.bagCategoriesCollection)
        .get();

    return bagCategories.docs
        .map((category) => CategoryModel.fromJson(category.data()))
        .toList();
  }
}
