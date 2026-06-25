import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:market/core/api_services.dart';
import 'package:market/features/proudct_details/logic/models/rate_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
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

  // User Add Rate to Proudct

  Future<void> addRateOrUpdateUserRate({required String productId,required Map<String, dynamic> rateData}) async {
    emit(AddOrUpdateUserRateLoading());
    try {
      if (_checkIfUserHasRated(productId: productId)) {
        // Update User Rate
        await _apiServices.patchData(
          "rates?for_user=eq.$userId&for_product=eq.$productId",
          rateData,
        );
      } else {
        // Add User Rate
        await _apiServices.postData("rates", rateData);
      }
      emit(AddOrUpdateUserRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddOrUpdateUserRateError(e.toString()));
    }
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try{
      await _apiServices.postData("comments", data);
      emit(AddCommentSuccess());
    }
    catch(e){
      if (e is DioException) {
    log("STATUS => ${e.response?.statusCode}");
    log("DATA => ${e.response?.data}");
  }
  log(e.toString());
  emit(AddCommentError(e.toString()));
    }
  }

  void _getUserRateForProudct() {
    userRates = rates.where((rate) => rate.forUser == userId).toList();
    productRate = userRates.isNotEmpty ? userRates[0].rate! : 5;
  }

  void _getAvreageRate() {
    for (var rate in rates) {
      if (rate.rate != null) {
        averageRate += rate.rate!;
      }
    averageRate = rates.isNotEmpty ? (averageRate / rates.length).round() : 0;
    }
  }

  bool _checkIfUserHasRated({required String productId}) {
    for (var rate in rates) {
      if (rate.forUser == userId && rate.forProduct == productId) {
        return true;
      }
    }
    return false;
  }
}
