import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/error/failure.dart';
import 'package:market/core/networke/api_services.dart';
import 'package:market/core/networke/dio_clint.dart';
import 'package:market/features/proudct_details/logic/models/rates/rates.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'proudct_details_state.dart';

class GetRatesCubit extends Cubit<ProudctDetailsState> {
  GetRatesCubit() : super(GetRatesInitial());
  final ApiServices _apiServices = ApiServices(DioClient());
  String usrId = Supabase.instance.client.auth.currentUser!.id;
  List<Rates> rates = [];
  int averageRate = 0;
  int userRate = 0;
  Future<void> getUserRateForSpecificProduct({
    required String productId,
  }) async {
    try {
      emit(GetRatesLoading());
      final response = await _apiServices.get(
        '/rates?select=*&for_proudct=eq.$productId',
      );
      // مهم جدًا
      rates.clear();
      for (var rate in response.data) {
        rates.add(Rates.fromJson(rate));
      }
      _getAvrageRate();
      final List<Rates> userRates = _getUserRate();
      log('user rates length: ${userRates.length}');
      log('User Rate: $userRate');
      log('Average Rate: $averageRate');
      emit(GetRatesSuccess());
    } on Failure catch (e) {
      emit(GetRatesError(e.message));
      log('Failure in getUserRateForSpecificProduct: ${e.message}');
    } catch (e) {
      emit(GetRatesError('An error occurred'));
      log('Error in getUserRateForSpecificProduct: $e');
    }
  }

  Future<void> addOrUpdateRateForSpecificProduct({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    try {
      emit(AddOrUpdateRateLoading());
      if (isUserRated(productId: productId)) {
        await _apiServices.patch(
          '/rates?for_user=eq.$usrId&for_proudct=eq.$productId',
          data: data,
        );
      } else {
        await _apiServices.post(
          '/rates',
          data: data,
        );
      }

      // جيب الـ rates الجديدة واحسب الـ average من جديد
      await getUserRateForSpecificProduct(
        productId: productId,
      );
    } on Failure catch (e) {
      emit(AddOrUpdateRateError(e.message));
      log('Failure in addOrUpdateRateForSpecificProduct: ${e.message}');
    } catch (e) {
      emit(AddOrUpdateRateError(e.toString()));
      log('Error in addOrUpdateRateForSpecificProduct: $e');
    }
  }

  bool isUserRated({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUser == usrId) && (rate.forProudct == productId)) {
        return true;
      }
    }
    return false;
  }

  List<Rates> _getUserRate() {
    List<Rates> userRates = rates
        .where(
          (rate) => rate.forUser == usrId,
        )
        .toList();
    userRate = userRates.isNotEmpty ? userRates[0].rate ?? 0 : 0;
    return userRates;
  }

  void _getAvrageRate() {
    averageRate = 0;
    for (var rate in rates) {
      if (rate.rate != null) {
        averageRate += rate.rate!;
      }
    }
    averageRate = rates.isEmpty ? 3 : (averageRate / rates.length).round();
  }

  // add user comment
  Future<void> addUserComment({required Map<String, dynamic> data}) async {
    try {
      emit(AddCommentLoading());
      await _apiServices.post('/comments', data: data);
      emit(AddCommentSuccess());
    } on Failure catch (e) {
      emit(AddCommentError(e.message));
      log('Failure in addUserComment: ${e.message}');
    } catch (e) {
      emit(AddCommentError(e.toString()));
      log('Error in addUserComment: $e');
    }
  }
}
