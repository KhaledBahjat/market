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

final class SignUpSucces extends AuthState {
  final String?message;

  SignUpSucces(this.message);

}

final class SignUpError extends AuthState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}
final class AuthAuthenticated extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutError extends AuthState {
  final String errorMessage;

  SignOutError(this.errorMessage);
}
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends AuthState {
  final String errorMessage;

  ForgotPasswordError(this.errorMessage);
}

class GoogleSignInLoading extends AuthState {}

class GoogleSignInSuccess extends AuthState {}

class GoogleSignInCancelled extends AuthState {}

class GoogleSignInError extends AuthState {
  final String errorMessage;

  GoogleSignInError(this.errorMessage);
}
