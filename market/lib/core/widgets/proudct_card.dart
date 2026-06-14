import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';

class ProudctCard extends StatelessWidget {
  const ProudctCard(this.product, {
    super.key,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(AppRouts.proudctDetails),
      child: Card(
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
                  child: CachedNetworkImage(
                    imageUrl:product.imageUrl?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      width: double.infinity,
                      color: AppColors.kGreyColor.withValues(alpha: 0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
      
                  ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      width: double.infinity,
                      color: AppColors.kGreyColor.withValues(alpha: 0.5),
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(10),
      
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      '${product.sale}% Off',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      
            Height(height: 5),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.proudctName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                            '\$${product.proudctPrice} LE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                          Text(
                            '\$${product.oldPrice} LE',
                            style: TextStyle(
                              fontSize: 14,
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
                        child: Text('Buy Now',style: TextStyle(color: AppColors.kWhiteColor)),
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
