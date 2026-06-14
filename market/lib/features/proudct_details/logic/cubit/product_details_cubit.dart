import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/api_services.dart';
import 'package:market/features/proudct_details/logic/models/rate_model.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();
  List<RateModel> rates = [];
  int averageRate = 0;
  Future<void> getProductRates({required String productId}) async {
    emit(GetProductRateLoading());
    try {
      final response = await _apiServices.getData(
        "rates?&select=*&for_product=eq.$productId",
      );
      rates = (response.data)
          .map<RateModel>((item) => RateModel.fromJson(item))
          .toList();
          log(rates.toString());
      emit(GetProductRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetProductRateError(e.toString()));
    }
  }
}
