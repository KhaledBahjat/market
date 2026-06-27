import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/api_services.dart';
import 'package:market/core/model/product_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryResults = [];
  Map<String,bool> favoriteProudcts={};
  final String userId=Supabase.instance.client.auth.currentUser!.id;
  Future<void> getProducts({String? query,String? category}) async {
    emit(GetDataLoading());
    try {
      final response = await _apiServices.getData(
        "product?select=*,favorite(*),purchase(*)",
      );
      log(response.toString());
      products = (response.data)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
          searchProducts(query);
          getProductsByCategory(category);
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError(e.toString()));
    }
  }

  Future<void>addProductToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      final response = await _apiServices.postData(
        "favorite",
        {
          "is_favorite": true,
          "for_product":productId,
          "for_user": userId
        }
      );
      log(response.toString());
      favoriteProudcts.addAll({productId:true});
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError(e.toString()));
    }
  }
bool isProductFavorite(String productId) {
    return favoriteProudcts[productId] ?? false;
  }
  Future<void>removeProductFromFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      final response = await _apiServices.deleteData(
        "favorite?for_product=eq.$productId&for_user=eq.$userId",
      );
      log(response.toString());
      favoriteProudcts.removeWhere((key, value) => key == productId);
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteError(e.toString()));
    }
  }
  void searchProducts(String? query) {
    if (query != null && query.isNotEmpty) {
      searchResults.clear();
      for (var proudct in products) {
        if (proudct.proudctName.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(proudct);
        }
      }
    }
  }

  void getProductsByCategory(String? category) {
    if(category != null && category.isNotEmpty) {
      categoryResults.clear();
      for (var proudct in products) {
        if (proudct.category.trim().toLowerCase() == category.toLowerCase()) {
          categoryResults.add(proudct);
        }
      }
    }
  }
}
