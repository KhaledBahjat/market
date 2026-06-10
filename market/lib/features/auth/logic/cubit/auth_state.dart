part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class SignUpFailure extends AuthState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}


final class GoogleSignInLoading extends AuthState {}
final class GoogleSignInSuccess extends AuthState {}
final class GoogleSignInFailure extends AuthState {
  final String errorMessage;
  GoogleSignInFailure(this.errorMessage);
}


final class LogoutLoading extends AuthState {}
final class LogoutSuccess extends AuthState {}
final class LogoutFailure extends AuthState {
  final String errorMessage;
  LogoutFailure(this.errorMessage);
}
