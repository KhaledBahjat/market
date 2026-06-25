import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/api_services.dart';
import 'package:market/core/model/product_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryResults = [];
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
