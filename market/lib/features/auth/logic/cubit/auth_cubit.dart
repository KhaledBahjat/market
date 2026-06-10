import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  var client = Supabase.instance.client;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(LoginFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(password: password, email: email);
      if (client.auth.currentUser is User) {
        await addUserData(name: name, email: email);
      }
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(SignUpFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      const webClientId =
          '123359603602-6epquaicplt1ct1lqskkhko2n5s9kiss.apps.googleusercontent.com';
      final scopes = ['email', 'profile'];
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: webClientId);
      final googleUser = await googleSignIn.attemptLightweightAuthentication();
      if (googleUser == null) {
        throw AuthException('Failed to sign in with Google.');
      }
      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }
      var response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      log("Response: $response");
      await addUserData(
        name: googleUser.displayName ?? '',
        email: googleUser.email,
      );
      emit(GoogleSignInSuccess());
    } on Exception catch (e) {
      emit(GoogleSignInFailure(e.toString()));
      log("Error when to Sign in with google: $e");
    }
  }

  // log out function
  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(LogoutFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(LogoutFailure(e.toString()));
    }
  }

  // reset password function
  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(PasswordResetFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(PasswordResetFailure(e.toString()));
    }
  }

  // addeduserdata function

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    emit(AddedUserDataLoading());
    try {
      final user = client.auth.currentUser;
      if (user == null) {
        throw AuthException('No authenticated user found.');
      }
      final response = await client.from('users').upsert({
        'id': client.auth.currentUser!.id,
        'name': name,
        'email': email,
      });
      emit(AddedUserDataSuccess());
      log("Add User Data Response: $response");
    } on AuthException catch (e) {
      log(e.message);
      emit(AddedUserDataFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(AddedUserDataFailure(e.toString()));
    }
  }
}
