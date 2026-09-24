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

  final List<ProudctModel> proudctsByCategory = [];

  Future<void> getProducts({
    String? query,
    String? categoryName,
  }) async {
    try {
      emit(GetDataLoading());

      final response = await api.get('/proudcts');

      // مهم جدًا عشان المنتجات متتكررش
      allProudcts.clear();

      for (final proudct in response.data) {
        allProudcts.add(
          ProudctModel.fromJson(proudct),
        );
      }

      log('Total Products: ${allProudcts.length}');
      log('Category Requested: $categoryName');

      // Search
      search(query);

      // Category
      getProudctsByCategory(categoryName);

      log(
        'Products in Category: ${proudctsByCategory.length}',
      );

      emit(GetDataSuccess());
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

  // ================= SEARCH =================

void search(String? query) {
  filterdProudcts.clear();

  if (query == null || query.trim().isEmpty) {
    emit(GetDataSuccess());
    return;
  }

  final searchQuery = query.trim().toLowerCase();

  for (final product in allProudcts) {
    final productName =
        product.proudctName?.trim().toLowerCase();

    if (productName != null &&
        productName.contains(searchQuery)) {
      filterdProudcts.add(product);
    }
  }

  log(
    'Search: $query | '
    'Results: ${filterdProudcts.length}',
  );

  emit(GetDataSuccess());
}

  // ================= CATEGORY =================

  void getProudctsByCategory(String? categoryName) {
    proudctsByCategory.clear();

    if (categoryName == null ||
        categoryName.trim().isEmpty) {
      return;
    }

    final category = categoryName.trim().toLowerCase();

    for (final product in allProudcts) {
      final productCategory =
          product.proudcCategory?.trim().toLowerCase();

      if (productCategory == category) {
        proudctsByCategory.add(product);
      }
    }

    log(
      'Category: $categoryName | '
      'Products Found: ${proudctsByCategory.length}',
    );
  }
}