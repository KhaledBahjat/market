import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';

class CategorysList extends StatelessWidget {
  const CategorysList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kPrimaryColor,
                radius: 30,
                child: Icon(
                  categories[index].icon,
                  color: AppColors.kWhiteColor,
                  size: 30,
                ),
              ),
              Height(height: 5),
              Text(
                categories[index].name,
                style:  TextStyle(fontSize: 15.sp),
              ),
            ],
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
