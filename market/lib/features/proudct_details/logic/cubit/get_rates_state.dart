part of 'get_rates_cubit.dart';

@immutable
sealed class GetRatesState {}

final class GetRatesInitial extends GetRatesState {}

final class GetRatesLoading extends GetRatesState {}

final class GetRatesError extends GetRatesState {
  final String message;

  GetRatesError(this.message);
}

final class GetRatesSuccess extends GetRatesState {}

final class AddOrUpdateRateSuccess extends GetRatesState {}

final class AddOrUpdateRateError extends GetRatesState {
  final String message;

  AddOrUpdateRateError(this.message);
}

final class AddOrUpdateRateLoading extends GetRatesState {}
