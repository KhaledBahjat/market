import 'package:go_router/go_router.dart';
import 'package:market/core/proudct_model/proudct_model.dart';

import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/routing/app_transitions.dart';

import 'package:market/features/auth/nav_bar/ui/main_home.dart';
import 'package:market/features/auth/ui/forget_password.dart';
import 'package:market/features/auth/ui/sign_in.dart';
import 'package:market/features/auth/ui/sign_up.dart';
import 'package:market/features/home/ui/category_view.dart';
import 'package:market/features/home/ui/search_view.dart';
import 'package:market/features/profile/ui/edit_profile.dart';
import 'package:market/features/profile/ui/my_order.dart';
import 'package:market/features/proudct_details/ui/proudct_detils.dart';
import 'package:market/splash_screen.dart';

class RouterGenerator {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouts.splashScreen,
    routes: [
      GoRoute(
        path: AppRouts.splashScreen,
        name: AppRouts.splashScreen,
        pageBuilder: (context, state) {
          return AppTransitions.fade(
            key: state.pageKey,
            child: SplashScreen(),
          );
        },
      ),
    GoRoute(
  path: AppRouts.searchView,
  name: AppRouts.searchView,
  pageBuilder: (context, state) {
    final query = state.extra as String? ?? '';

    return AppTransitions.slideFromBottom(
      key: state.pageKey,
      child: SearchView(query: query),
    );
  },
),
   GoRoute(
  path: AppRouts.categoryView,
  name: AppRouts.categoryView,
  pageBuilder: (context, state) {
    final categoryName = state.extra as String? ?? '';

    return AppTransitions.slideFromBottom(
      key: state.pageKey,
      child: CategoryView(categoryName: categoryName,),
    );
  },
),
      GoRoute(
        path: AppRouts.signInScreen,
        name: AppRouts.signInScreen,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromLeft(
            key: state.pageKey,
            child: SignIn(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.signUpScreen,
        name: AppRouts.signUpScreen,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromRight(
            key: state.pageKey,
            child: SignUp(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.forgetPasswordScreen,
        name: AppRouts.forgetPasswordScreen,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromBottom(
            key: state.pageKey,
            child: ForgetPassword(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.homeScreen,
        name: AppRouts.homeScreen,
        pageBuilder: (context, state) {
          return AppTransitions.fade(
            key: state.pageKey,
            child: MainHome(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.editProfileScreen,
        name: AppRouts.editProfileScreen,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromRight(
            key: state.pageKey,
            child: EditProfile(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.myOrderScreen,
        name: AppRouts.myOrderScreen,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromRight(
            key: state.pageKey,
            child: MyOrderScreen(),
          );
        },
      ),

      GoRoute(
        path: AppRouts.proudctDetails,
        name: AppRouts.proudctDetails,
        pageBuilder: (context, state) {
          return AppTransitions.slideFromRight(
            key: state.pageKey,
            child: ProudctDetils(
              proudctModel: state.extra as ProudctModel,
            ),
          );
        },
      ),
    ],
  );
}
