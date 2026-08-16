import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:market/core/constant.dart';
import 'package:market/core/networke/api_services.dart';
import 'package:market/core/networke/dio_clint.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices api = ApiServices(DioClient());
  Future<void> getProducts() async {
    try {
      emit(GetDataLoading());
      var data = await api.get(EndPoints.getProudcts);
      log('response is $data');
      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError(e.toString()));
      log(e.toString());
    }
  }
}
