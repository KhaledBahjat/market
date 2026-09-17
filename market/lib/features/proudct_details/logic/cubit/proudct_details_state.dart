part of 'proudct_details_cubit.dart';

@immutable
sealed class ProudctDetailsState {}

final class GetRatesInitial extends ProudctDetailsState {}

final class GetRatesLoading extends ProudctDetailsState {}

final class GetRatesError extends ProudctDetailsState {
  final String message;

  GetRatesError(this.message);
}

final class GetRatesSuccess extends ProudctDetailsState {}

final class AddOrUpdateRateSuccess extends ProudctDetailsState {}

final class AddOrUpdateRateError extends ProudctDetailsState {
  final String message;

  AddOrUpdateRateError(this.message);
}

final class AddOrUpdateRateLoading extends ProudctDetailsState {}

final class AddCommentSuccess extends ProudctDetailsState {}
final class AddCommentError extends ProudctDetailsState {
  final String message;

  AddCommentError(this.message);
}
final class AddCommentLoading extends ProudctDetailsState {}
