import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/networke/api_services.dart';
import 'package:market/core/networke/dio_clint.dart';
import 'package:market/features/proudct_details/logic/models/rates/rates.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_rates_state.dart';

class GetRatesCubit extends Cubit<GetRatesState> {
  GetRatesCubit() : super(GetRatesInitial());
  final ApiServices _apiServices = ApiServices(DioClient());
  List<Rates> rates = [];
  int averageRate = 0;
  int userRate = 5;
  Future<void> getUserRateForSpecificProduct({
    required String productId,
  }) async {
    try {
      emit(GetRatesLoading());
      final response = await _apiServices.get(
        '/rates?select=*&for_proudct=eq.$productId',
      );
      for (var rate in response.data) {
        rates.add(Rates.fromJson(rate));
      }
      _getAvrageRate();
      List<Rates> userRates = _getUserRate();
      log('user rates length: ${userRates.length}');
      log('rate for user: ${rates[0].forUser}');
      log('Current User: ${Supabase.instance.client.auth.currentUser!.id}');
      log('User Rate: $userRate');
      emit(GetRatesSuccess());
    } catch (e) {
      emit(GetRatesError('An error occurred'));
      log('Error in getUserRateForSpecificProduct: $e');
    }
  }

  List<Rates> _getUserRate() {
    List<Rates> userRates = rates
        .where(
          (rate) =>
              rate.forUser == Supabase.instance.client.auth.currentUser!.id,
        )
        .toList();
    userRate = userRates[0].rate ?? 5;
    return userRates;
  }

  void _getAvrageRate() {
    for (var rate in rates) {
      if (rate.rate != null) {
        averageRate += rate.rate!;
      }
    }
    averageRate = rates.isEmpty ? 0 : (averageRate / rates.length).round();
  }
}
