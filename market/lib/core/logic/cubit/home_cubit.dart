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
  Future<void> getProducts({String? query}) async {
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
}
