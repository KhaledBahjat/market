import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';

class ProudctCard extends StatelessWidget {
  const ProudctCard({super.key, required this.proudct});

  final ProudctModel proudct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouts.proudctDetails, extra: proudct);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: proudct.imageUrls ?? "assets/imgs/test.jpg",
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.fill,

                    placeholder: (context, url) {
                      return Container(
                        height: 200.h,
                        width: double.infinity,
                        color: AppColors.kGreyColor.withValues(
                          alpha: 0.5,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      );
                    },

                    errorWidget:
                        (
                          context,
                          url,
                          error,
                        ) {
                          return Container(
                            height: 200.h,
                            width: double.infinity,
                            color: AppColors.kGreyColor.withValues(
                              alpha: 0.5,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          );
                        },
                  ),
                ),

                // Sale
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withValues(
                        alpha: 0.7,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      '${proudct.sale}% Off',
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Height(height: 5),

            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          proudct.proudctName ?? "Unknown Name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${proudct.proudctPrice} LE',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),

                          Text(
                            '\$${proudct.oldPrice} LE',
                            style: TextStyle(
                              fontSize: 14.sp,
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.kGreyColor,
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
