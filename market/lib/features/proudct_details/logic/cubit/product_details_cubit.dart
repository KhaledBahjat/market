import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/api_services.dart';
import 'package:market/features/proudct_details/logic/models/rate_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();
  List<RateModel> rates = [];
  int averageRate = 0;
  int productRate = 5;
  List<RateModel> userRates = [];
  Future<void> getProductRates({required String productId}) async {
    emit(GetProductRateLoading());
    try {
      final response = await _apiServices.getData(
        "rates?&select=*&for_product=eq.$productId",
      );
      rates = (response.data)
          .map<RateModel>((item) => RateModel.fromJson(item))
          .toList();

      _getAvreageRate();
      _getUserRateForProudct();
      log('User rates long   =${userRates.length}');
      log("rate.forUser= ${rates[0].forUser}");
      log("user id ${Supabase.instance.client.auth.currentUser!.id}");
      log("User rate is $productRate");
      emit(GetProductRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetProductRateError(e.toString()));
    }
  }

  void _getUserRateForProudct() {
    for (var rate in rates) {
      if (rate.forUser == Supabase.instance.client.auth.currentUser!.id) {
        userRates.add(rate);
      }
    }
    productRate = userRates.isNotEmpty ? userRates[0].rate! : 5;
  }

  void _getAvreageRate() {
    for (var rate in rates) {
      if (rate.rate != null) {
        averageRate += rate.rate!;
      }
      averageRate ~/= rates.length;
    }
  }
}
