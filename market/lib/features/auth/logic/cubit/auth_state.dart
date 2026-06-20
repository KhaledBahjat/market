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


final class PasswordResetLoading extends AuthState {}
final class PasswordResetSuccess extends AuthState {}
final class PasswordResetFailure extends AuthState {
  final String errorMessage;
  PasswordResetFailure(this.errorMessage);
}


final class AddedUserDataLoading extends AuthState {}
final class AddedUserDataSuccess extends AuthState {} 
final class AddedUserDataFailure extends AuthState {
  final String errorMessage;
  AddedUserDataFailure(this.errorMessage);
}


final class GetUserDataLoading extends AuthState {}
final class GetUserDataSuccess extends AuthState {
}
final class GetUserDataFailure extends AuthState {
  final String errorMessage;
  GetUserDataFailure(this.errorMessage);
}
