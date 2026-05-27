import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          CustomSearchFeild(),
          Height(height: 20),
          Image.asset('assets/imgs/market.jpg', fit: BoxFit.cover),
          Height(height: 20),
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
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
          ),
        ],
      ),
    );
  }
}

List<CategoryItem> categories = [
  CategoryItem(name: 'Phones', icon: Icons.phone_android),
  CategoryItem(name: 'Laptops', icon: Icons.laptop),
  CategoryItem(name: 'Headphones', icon: Icons.headphones),
  CategoryItem(name: 'Cameras', icon: Icons.camera_alt),
  CategoryItem(name: 'Smartwatches', icon: Icons.watch),
  CategoryItem(name: 'Gaming Consoles', icon: Icons.videogame_asset),
  CategoryItem(name: 'Tablets', icon: Icons.tablet_mac),
  CategoryItem(name: 'Smartphones', icon: Icons.phone),
  
];

class CategoryItem {
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}
