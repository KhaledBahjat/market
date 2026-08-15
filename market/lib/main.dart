import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/cache/shared_prefs.dart';
import 'package:market/core/constant.dart';
import 'package:market/core/observer.dart';
import 'package:market/core/routing/router_generator.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Secret.appUrl,
    publishableKey: Secret.anonKey,
  );
  await SharedPrefs.init();
  final authCubit = AuthCubit();
  await authCubit.initializeGoogleSignIn();
    Bloc.observer = AppBlocObserver();
  runApp(
    Market(
      authCubit: authCubit,
    ),
  );
}

class Market extends StatelessWidget {
  final AuthCubit authCubit;

  const Market({
    super.key,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: authCubit,
          ),
        ],
        child: MaterialApp.router(
          routerConfig: RouterGenerator.router,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Market',
        ),
      ),
    );
  }
}
