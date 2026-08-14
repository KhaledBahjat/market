part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInSucces extends AuthState {}

final class SignInError extends AuthState {
  final String errorMessage;

  SignInError(this.errorMessage);
}

final class SignUpLoading extends AuthState {}

final class SignUpSucces extends AuthState {}

final class SignUpError extends AuthState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}
