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
  const MainHome({super.key});
  final List<Widget> screens = const [Home(), Store(), Favorite(), Profile()];
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
              padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF121B2E),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GNav(
                    onTabChange: (value) => cubit.changeCurrentINdex(value),
                    rippleColor: AppColors.kPrimaryColor,
                    hoverColor: AppColors.kPrimaryColor,
                    haptic: true,
                    curve: Curves.easeOutExpo,
                    duration: const Duration(milliseconds: 350),
                    gap: 8,
                    color: AppColors.kGreyColor,
                    activeColor: AppColors.kPrimaryColor,
                    iconSize: 24,
                    tabBackgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.18),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    tabs: const [
                      GButton(icon: Icons.home, text: 'Home'),
                      GButton(icon: Icons.store, text: 'Store'),
                      GButton(icon: Icons.favorite, text: 'Favorite'),
                      GButton(icon: Icons.person, text: 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
