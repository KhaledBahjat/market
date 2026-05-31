import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/nav_bar/logic/cubit/nav_bar_cubit.dart';
import 'package:market/features/favorite/ui/favorite.dart';
import 'package:market/features/home/ui/home.dart';
import 'package:market/features/profile/ui/profile.dart';
import 'package:market/features/store/ui/store.dart';

class MainHome extends StatelessWidget {
  MainHome({super.key});
  final List<Widget> screens = [Home(), Store(), Favorite(), Profile()];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
         NavBarCubit cubit= context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(child: screens[cubit.currentINdex]),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
              child: GNav(
                onTabChange: (value) => cubit.changeCurrentINdex(value),
                rippleColor: AppColors.kPrimaryColor,
                hoverColor: AppColors.kPrimaryColor,
                haptic: true,
                curve: Curves.easeOutExpo,
                duration: Duration(milliseconds: 400),
                gap: 8,
                color: Colors.grey,
                activeColor: AppColors.kPrimaryColor,
                iconSize: 24,
                tabBackgroundColor: AppColors.kPrimaryColor.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabs: [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.store, text: 'Store'),
                  GButton(icon: Icons.favorite, text: 'Favorite'),
                  GButton(icon: Icons.person, text: 'Profile'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
