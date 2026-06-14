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
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      final response = await _apiServices.getData(
        "product?select=*,favorite(*),purchase(*)",
      );
      log(response.toString());
      products = (response.data).map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
          
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError(e.toString()));
    }
  }
}
