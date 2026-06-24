part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class GetProductRateLoading extends ProductDetailsState {}
final class GetProductRateSuccess extends ProductDetailsState {}
final class GetProductRateError extends ProductDetailsState {
  final String error;
  GetProductRateError(this.error);
}

final class AddOrUpdateUserRateLoading extends ProductDetailsState {}
final class AddOrUpdateUserRateSuccess extends ProductDetailsState {}
final class AddOrUpdateUserRateError extends ProductDetailsState {
  final String error;
  AddOrUpdateUserRateError(this.error);
}