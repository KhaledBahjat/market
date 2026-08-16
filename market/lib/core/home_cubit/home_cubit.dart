import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/constant.dart';
import 'package:market/core/error/failure.dart';
import 'package:market/core/networke/api_services.dart';
import 'package:market/core/networke/dio_clint.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices api = ApiServices(DioClient());
  Future<void> getProducts() async {
    try {
      emit(GetDataLoading());

      final response = await api.get(
        EndPoints.getProudcts,
      );

      final products = (response.data as List)
          .map(
            (product) => ProudctModel.fromJson(
              product as Map<String, dynamic>,
            ),
          )
          .toList();

      emit(GetDataSuccess(products));
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
}
