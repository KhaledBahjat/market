import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/routing/router_generator.dart';
import 'package:market/core/sensetive_data.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SENSITIVE_DATA["url"] as String,
    publishableKey: SENSITIVE_DATA["publishableKey"] as String,
  );
  runApp(Market());
}

class Market extends StatelessWidget {
  const Market({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp.router(
        routerConfig: RouterGenerator.router,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Market',
      ),
    );
  }
}
