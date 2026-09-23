import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imgs = [
    'assets/imgs/market.jpg',
    'assets/imgs/market.jpg',
    'assets/imgs/test.jpg',
  ];
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Height(height: 15),
          CustomSearchFeild(
            controller: _searchController,
            onPressed: () {
              context.pushNamed(
                AppRouts.searchView,
                extra: _searchController.text,
              );
              _searchController.clear();
            },
          ),
          Height(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: CarouselSlider.builder(
              itemCount: imgs.length,
              itemBuilder:
                  (
                    context,
                    index,
                    realIndex,
                  ) {
                    return Image.asset(
                      imgs[index],
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.fill,

                      // placeholder: (context, url) {
                      //   return Container(
                      //     height: 200.h,
                      //     width: double.infinity,
                      //     color: AppColors.kGreyColor.withValues(
                      //       alpha: 0.5,
                      //     ),
                      //     child: Center(
                      //       child: CircularProgressIndicator(
                      //         color: AppColors.kPrimaryColor,
                      //       ),
                      //     ),
                      //   );
                      // },

                      // errorWidget:
                      //     (
                      //       context,
                      //       url,
                      //       error,
                      //     ) {
                      //       return Container(
                      //         height: 200.h,
                      //         width: double.infinity,
                      //         color: AppColors.kGreyColor.withValues(
                      //           alpha: 0.5,
                      //         ),
                      //         child: Center(
                      //           child: Icon(
                      //             Icons.error,
                      //             color: AppColors.kPrimaryColor,
                      //           ),
                      //         ),
                      //       );
                      //     },
                    );
                  },
              options: CarouselOptions(
                height: 200.h,
                viewportFraction: 1,
                enableInfiniteScroll: imgs.length > 1,
                autoPlay: imgs.length > 1,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                enlargeCenterPage: false,
              ),
            ),
          ),
          Height(height: 20),
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          CategorysList(),
          Height(height: 10),

          Text(
            'Recently Added',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          ProudctList(),
        ],
      ),
    );
  }
}
