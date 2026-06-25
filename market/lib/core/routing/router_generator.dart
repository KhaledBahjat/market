import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/features/auth/nav_bar/ui/main_home.dart';
import 'package:market/features/auth/ui/forget_password.dart';
import 'package:market/features/auth/ui/sign_in.dart';
import 'package:market/features/auth/ui/sign_up.dart';
import 'package:market/features/home/ui/category_result.dart';
import 'package:market/features/home/ui/search_result.dart';
import 'package:market/features/profile/ui/edit_profile.dart';
import 'package:market/features/profile/ui/my_order.dart';
import 'package:market/features/proudct_details/ui/proudct_detils.dart';
import 'package:market/splash_screen.dart';

class RouterGenerator {
  static GoRouter router = GoRouter(
    initialLocation: AppRouts.splashScreen,
    routes: [
      GoRoute(
        path: AppRouts.categoryResultScreen,
        name: AppRouts.categoryResultScreen,
        builder: (context, state) => CategoryResult(category: state.extra as String? ?? 'Unknown Category'),
      ),
      GoRoute(
        path: AppRouts.searchScreen,
        name: AppRouts.searchScreen,
        builder: (context, state) => SearchResult(query: state.extra as String?,),
      ),
      GoRoute(
        path: AppRouts.splashScreen,
        name: AppRouts.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
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
      GoRoute(
        path: AppRouts.editProfileScreen,
        name: AppRouts.editProfileScreen,
        builder: (context, state) => EditProfile(),
      ),
      GoRoute(
        path: AppRouts.myOrderScreen,
        name: AppRouts.myOrderScreen,
        builder: (context, state) => MyOrderScreen(),
      ),
      GoRoute(
        path: AppRouts.proudctDetails,
        name: AppRouts.proudctDetails,
        builder: (context, state) {
          final product = state.extra as ProductModel?;
          if (product == null) {
            return  Scaffold(
              body: Center(
                child: Text('Product details are unavailable.'),
              ),
            );
          }
          return ProudctDetils(product: product);
        },
      ),
    ],
  );
}
