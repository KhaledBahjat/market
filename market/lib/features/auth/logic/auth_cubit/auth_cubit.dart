import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market/core/networke/cache/shared_prefs.dart';
import 'package:market/core/constant.dart';
import 'package:market/features/auth/logic/models/user_model.dart';
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

      // Get from Supabase + save in SharedPreferences
      await getUserData();

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
    required String name,
  }) async {
    try {
      emit(SignUpLoading());

      final response = await clint.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      final session = response.session;

      log('Sign Up $response');
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
      await addUserData(name: name, email: email);
      await getUserData();
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

      // Clear cached user data
      await SharedPrefs.remove(AppKeys.userId);
      await SharedPrefs.remove(AppKeys.userName);
      await SharedPrefs.remove(AppKeys.userEmail);

      log('Sign out successful');
      log('Cached user data removed');

      emit(SignOutSuccess());
    } on AuthException catch (e) {
      log('Sign out error: ${e.message}');
      emit(SignOutError(e.message));
    } catch (e) {
      log('Unexpected error: $e');
      emit(SignOutError('Something went wrong'));
    }
  }

  Future<void> loadUserData() async {
    final cachedUser = getCachedUser();

    if (cachedUser != null) {
      log('Loading user from cache');

      emit(GetUserDataSuccess(cachedUser));
      return;
    }

    log('No cached user found, fetching from Supabase');

    await getUserData();
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

      final googleUser = await googleSignIn.authenticate();

      log('Google user: ${googleUser.email}');

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

      final authorization = await googleUser.authorizationClient
          .authorizationForScopes([
            'openid',
            'email',
            'profile',
          ]);

      final accessToken = authorization?.accessToken;

      if (accessToken == null) {
        emit(
          GoogleSignInError(
            'Google access token not found.',
          ),
        );
        return;
      }

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

      // Add user data to database
      await addGoogleUserData();
      await getUserData();
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
        GoogleSignInError(e.message),
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

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    try {
      emit(AddUserDataLoading());

      final user = clint.auth.currentUser;

      if (user == null) {
        emit(
          AddUserDataError(
            'User is not authenticated',
          ),
        );
        return;
      }

      await clint.from('users').upsert({
        'id': user.id,
        'name': name.trim(),
        'email': email.trim(),
      });

      log('User data added successfully');
      log('User ID: ${user.id}');

      emit(AddUserDataSuccess());
    } on PostgrestException catch (e) {
      log('Supabase Error: ${e.message}');
      log('Code: ${e.code}');
      log('Details: ${e.details}');

      emit(AddUserDataError(e.message));
    } catch (e) {
      log('Unexpected Error: $e');

      emit(
        AddUserDataError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> addGoogleUserData() async {
    try {
      emit(AddUserDataLoading());

      final user = clint.auth.currentUser;

      if (user == null) {
        emit(
          AddUserDataError(
            'User is not authenticated.',
          ),
        );
        return;
      }

      final metadata = user.userMetadata;

      final name = metadata?['full_name'] ?? metadata?['name'] ?? 'User';

      final email = user.email;

      if (email == null) {
        emit(
          AddUserDataError(
            'User email not found.',
          ),
        );
        return;
      }

      await clint.from('users').upsert({
        'id': user.id,
        'name': name,
        'email': email,
      });

      log('Google user data added successfully');
      log('User ID: ${user.id}');
      log('Name: $name');
      log('Email: $email');

      emit(AddUserDataSuccess());
    } on PostgrestException catch (e) {
      log('Database Error: ${e.message}');
      log('Code: ${e.code}');

      emit(
        AddUserDataError(e.message),
      );
    } catch (e) {
      log('Unexpected Error: $e');

      emit(
        AddUserDataError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> getUserData() async {
    try {
      emit(GetUserDataLoading());

      final user = clint.auth.currentUser;

      if (user == null) {
        emit(GetUserDataError('User is not authenticated'));
        return;
      }

      final response = await clint
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      log('User response: $response');

      final userModel = UserModel.fromJson(response);

      // Save user data in cache
      await SharedPrefs.setString(
        AppKeys.userId,
        userModel.id,
      );

      await SharedPrefs.setString(
        AppKeys.userName,
        userModel.name,
      );

      await SharedPrefs.setString(
        AppKeys.userEmail,
        userModel.email,
      );

      log('User cached successfully');
      log('Name: ${userModel.name}');
      log('Email: ${userModel.email}');
      emit(GetUserDataSuccess(userModel));
    } on PostgrestException catch (e) {
      log('Database Error: ${e.message}');
      log('Code: ${e.code}');
      log('Details: ${e.details}');

      emit(GetUserDataError(e.message));
    } catch (e) {
      log('Unexpected Error: $e');

      emit(
        GetUserDataError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  UserModel? getCachedUser() {
    final id = SharedPrefs.getString(AppKeys.userId);
    final name = SharedPrefs.getString(AppKeys.userName);
    final email = SharedPrefs.getString(AppKeys.userEmail);

    if (id == null || name == null || email == null) {
      return null;
    }

    return UserModel(
      id: id,
      name: name,
      email: email,
    );
  }
}
