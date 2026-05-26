import 'package:go_router/go_router.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/features/auth/nav_bar/ui/main_home.dart';
import 'package:market/features/auth/ui/forget_password.dart';
import 'package:market/features/auth/ui/sign_in.dart';
import 'package:market/features/auth/ui/sign_up.dart';

class RouterGenerator {
  static GoRouter router = GoRouter(
    initialLocation: AppRouts.homeScreen,
    routes: [
      GoRoute(
        path: AppRouts.signInScreen,
        name: AppRouts.signInScreen,
        builder: (context, state) => SignIn(),
      ),
      GoRoute(
        path: AppRouts.signUpScreen,
        name: AppRouts.signUpScreen,
        builder: (context, state) => SignUp(),
      ),
      GoRoute(
        name: AppRouts.forgetPasswordScreen,
        path: AppRouts.forgetPasswordScreen,
        builder: (context, state) => ForgetPassword(),
      ),
      GoRoute(
        path: AppRouts.homeScreen,
        name: AppRouts.homeScreen,
        builder: (context, state) => MainHome(),
      ),
    ],
  );
}
