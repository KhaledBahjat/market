import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';

class CategorysList extends StatelessWidget {
  const CategorysList({
    super.key,
    this.category,
  });
  final String? category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              GoRouter.of(context).pushNamed(
                AppRouts.categoryResultScreen,
                extra: categories[index].name,
              );
            },
            child: Container(
              // width: 84.w,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF121B2E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.kBordersideColor.withValues(alpha: 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.kPrimaryColor,
                          AppColors.kPrimaryColor.withValues(alpha: 0.72),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categories[index].icon,
                      color: AppColors.kWhiteColor,
                      size: 26,
                    ),
                  ),
                  Height(height: 10),
                  Text(
                    categories[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: categories.length,
      ),
    );
  }
}

List<CategoryItem> categories = [
  CategoryItem(name: 'Electronics', icon: Icons.phone_android),
  CategoryItem(name: 'Fashion', icon: Icons.shopping_bag),
  CategoryItem(name: 'Home', icon: Icons.home),
  CategoryItem(name: 'Beauty', icon: Icons.brush),
  CategoryItem(name: 'Sports', icon: Icons.sports),
  CategoryItem(name: 'Toys', icon: Icons.toys),
  CategoryItem(name: 'Books', icon: Icons.book),
  CategoryItem(name: 'Automotive', icon: Icons.directions_car),
  
  
];

class CategoryItem {
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}
