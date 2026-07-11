import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/my_observer.dart';
import 'package:market/core/routing/router_generator.dart';
import 'package:market/core/sensetive_data.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/logic/cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SENSITIVE_DATA["url"] as String,
    publishableKey: SENSITIVE_DATA["publishableKey"] as String,
  );
  Bloc.observer = MyObserver();
  runApp(Market());
}

class Market extends StatelessWidget {
  const Market({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.kPrimaryColor,
      brightness: Brightness.dark,
    );
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp.router(
          routerConfig: RouterGenerator.router,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: colorScheme,
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.kBlackColor,
              surfaceTintColor: Colors.transparent,
            ),
            cardTheme: CardThemeData(
              color: const Color(0xFF121B2E),
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: AppColors.kBordersideColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF121B2E),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.kBordersideColor.withValues(alpha: 0.9),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.kPrimaryColor,
                  width: 1.5,
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: AppColors.kScaffoldColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: AppColors.kBordersideColor),
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFFE2E8F0)),
              bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
              titleLarge: TextStyle(color: Color(0xFFF8FAFC)),
              titleMedium: TextStyle(color: Color(0xFFF8FAFC)),
              headlineSmall: TextStyle(color: Color(0xFFF8FAFC)),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: colorScheme,
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          title: 'Market',
        ),
      ),
    );
  }
}
