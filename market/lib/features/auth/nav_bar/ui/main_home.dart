import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market/core/theme/app_colors.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(child: Text('Test')),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 18.w),
        child: GNav(
          rippleColor:
              AppColors.kPrimaryColor, 
          hoverColor: AppColors.kPrimaryColor, 
          haptic: true,
          curve: Curves.easeOutExpo, 
          duration: Duration(milliseconds: 400), 
          gap: 8, 
          color: Colors.grey,
          activeColor: AppColors.kPrimaryColor,
          iconSize: 24, 
          tabBackgroundColor: AppColors.kPrimaryColor.withOpacity(
            0.1,
          ), 
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ), 
          tabs: [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.store, text: 'Store'),
            GButton(icon: Icons.favorite, text: 'Favorite'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
