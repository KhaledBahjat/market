import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  SupabaseClient clint = Supabase.instance.client;
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
}
