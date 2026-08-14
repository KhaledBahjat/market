import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
}
