part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {
  final List<ProudctModel> products;

  GetDataSuccess(this.products);
}

final class GetDataError extends HomeState {
  final String errorMessage;

  GetDataError(this.errorMessage);
}

final class GetPopularLoading extends HomeState {}

final class GetPopularSuccess extends HomeState {
  final Populare pop;

  GetPopularSuccess(this.pop);
}

final class GetPopularError extends HomeState {
  final String errorMessage;

  GetPopularError(this.errorMessage);
}
