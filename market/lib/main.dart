import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/constant.dart';
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
  runApp(Market());
}

class Market extends StatelessWidget {
  const Market({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
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
