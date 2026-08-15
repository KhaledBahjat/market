import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();
  SupabaseClient clint = Supabase.instance.client;
  Future<void> checkAuthState() async {
    final session = clint.auth.currentSession;
    log('Checking auth state...');
    log('Session: $session');

    if (session != null) {
      log('User is authenticated');
      emit(AuthAuthenticated());
    } else {
      log('User is not authenticated');
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(SignInLoading());

      final response = await clint.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        emit(SignInError('User not found'));
        return;
      }

      log('Login successful');
      log('User ID: ${user.id}');

      emit(SignInSucces());
    } on AuthException catch (e) {
      log('Auth Error: ${e.message}');
      emit(SignInError(e.message));
    } catch (e) {
      log('Unexpected Error: $e');
      emit(SignInError(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(SignUpLoading());

      final response = await clint.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      final session = response.session;

      log('Sign Up response');
      log('User ID: ${user?.id}');
      log('Session: $session');

      // Failed to create user
      if (user == null) {
        emit(
          SignUpError('Failed to create account. Please try again.'),
        );
        return;
      }
      // Email confirmation is required
      if (session == null) {
        log('Account created successfully.');
        log('Email verification is required.');
        emit(
          SignUpSucces(
            'Account created successfully.\n'
            'Please check your email and activate your account.',
          ),
        );

        return;
      }

      // Account created and user is already authenticated
      log('Sign Up successful');
      log('User ID: ${user.id}');

      emit(
        SignUpSucces(
          'Account created successfully.',
        ),
      );
    } on AuthException catch (e) {
      log('Auth Error: ${e.message}');
      log('Status Code: ${e.statusCode}');
      log('Code: ${e.code}');

      emit(
        SignUpError(e.message),
      );
    } catch (e) {
      log('Unexpected Error: $e');

      emit(
        SignUpError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }


  Future<void> signOut() async {
    try {
      emit(SignOutLoading());

      await clint.auth.signOut();

      log('Sign out successful');

      emit(SignOutSuccess());
    } on AuthException catch (e) {
      log('Sign out error: ${e.message}');
      emit(SignOutError(e.message));
    } catch (e) {
      log('Unexpected error: $e');
      emit(SignOutError('Something went wrong'));
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      emit(ForgotPasswordLoading());

      await clint.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'market://reset-password',
      );

      log('Password reset email sent');

      emit(
        ForgotPasswordSuccess(
          'Password reset email has been sent. Please check your email.',
        ),
      );
    } on AuthException catch (e) {
      log('Forgot password error: ${e.message}');
      log('Status Code: ${e.statusCode}');
      log('Code: ${e.code}');

      emit(ForgotPasswordError(e.message));
    } catch (e) {
      log('Unexpected error: $e');

      emit(
        ForgotPasswordError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<void> initializeGoogleSignIn() async {
    await googleSignIn.initialize(
      serverClientId:
          '123359603602-0nrbrr0jui3gppd0kah3i1q72q5pf7vv.apps.googleusercontent.com',
    );

    log('Google Sign In initialized');
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(GoogleSignInLoading());

      // Start Google authentication
      final googleUser = await googleSignIn.authenticate();

      log('Google user: ${googleUser.email}');

      // Get ID Token
      final googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(
          GoogleSignInError(
            'Google ID token not found.',
          ),
        );
        return;
      }

      // Get Access Token
      final authorization = await googleUser.authorizationClient
          .authorizationForScopes(
            [
              'openid',
              'email',
              'profile',
            ],
          );

      final accessToken = authorization?.accessToken;

      if (accessToken == null) {
        emit(
          GoogleSignInError(
            'Google access token not found.',
          ),
        );
        return;
      }

      // Sign in to Supabase
      final response = await clint.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final user = response.user;

      if (user == null) {
        emit(
          GoogleSignInError(
            'Failed to sign in with Google.',
          ),
        );
        return;
      }

      log('Google Sign In successful');
      log('User ID: ${user.id}');
      log('Email: ${user.email}');

      emit(GoogleSignInSuccess());
    } on GoogleSignInException catch (e) {
      log('Google Sign In Error: ${e.code}');
      log('$e');

      emit(
        GoogleSignInError(
          'Google Sign In failed.',
        ),
      );
    } on AuthException catch (e) {
      log('Supabase Auth Error: ${e.message}');

      emit(
        GoogleSignInError(
          e.message,
        ),
      );
    } catch (e) {
      log('Unexpected Google Sign In Error: $e');

      emit(
        GoogleSignInError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
