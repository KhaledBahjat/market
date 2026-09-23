import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/error/failure.dart';
import 'package:market/core/networke/api_services.dart';
import 'package:market/core/networke/dio_clint.dart';
import 'package:market/core/populare/populare.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices api = ApiServices(DioClient());
  final List<ProudctModel> allProudcts = [];
  final List<ProudctModel> filterdProudcts = [];
  Future<void> getProducts({String?query}) async {
    try {
      emit(GetDataLoading());
      final response = await api.get(
        '/proudcts',
      );

      for (var proudct in response.data) {
        allProudcts.add(ProudctModel.fromJson(proudct));
      }
      // log('proudct response : $response');
      search(query);
      emit(GetDataSuccess(allProudcts));
    } on Failure catch (e) {
      log('Get Products Error: ${e.message}');

      emit(
        GetDataError(e.message),
      );
    } catch (e) {
      log('Unexpected Error: $e');

      emit(
        GetDataError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  void search(String? query) {
    if (query == null || query.trim().isEmpty) {
      filterdProudcts.clear();
      return;
    }

    filterdProudcts.clear();

    for (var product in allProudcts) {
      if (product.proudctName!.toLowerCase().contains(query.toLowerCase())) {
        filterdProudcts.add(product);
      }
    }
  }
}
