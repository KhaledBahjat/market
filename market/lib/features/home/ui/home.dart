import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

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
          CategorysList(),
          Height(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
                  
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,

                      ),
                    ),
                    Positioned(child: Container(
                      padding: EdgeInsets.all(10),
                      
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        '10% Off',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),),
                  ],
               
               
                ),
              
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
