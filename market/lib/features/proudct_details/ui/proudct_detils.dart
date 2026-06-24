import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/proudct_details/logic/cubit/product_details_cubit.dart';
import 'package:market/features/proudct_details/widgets/comment_list.dart';

class ProudctDetils extends StatelessWidget {
  const ProudctDetils({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getProductRates(productId: product.proudctId),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if(state is AddOrUpdateUserRateSuccess){
            GoRouter.of(context).pushReplacementNamed(
              AppRouts.proudctDetails,
              extra: product,
            );
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit=context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(product.proudctName),
              centerTitle: true,
            ),
            body: state is GetProductRateLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : ListView(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            product.imageUrl ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
                        width: double.infinity,
                        height: 250.h,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.proudctName),
                                Text('${product.proudctPrice}\$'),
                              ],
                            ),
                            Height(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(cubit.averageRate.toString()),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite),
                                ),
                              ],
                            ),

                            Text(product.desc),
                            Height(height: 20),
                            RatingBar.builder(
                              initialRating: cubit.productRate.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              
                              onRatingUpdate: (rating) {
                                cubit.addRateOrUpdateUserRate(
                                  productId: product.proudctId,
                                  rateData: {
                                    "for_user": cubit.userId,
                                    "for_product": product.proudctId,
                                    "rate": rating.toInt(),
                                  },
                                );
                              },
                            ),
                            Height(height: 16),
                            CustomTextFormFeild(
                              labelText: 'Type your feedback',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.send),
                              ),
                            ),
                            Height(height: 15),
                            Text(
                              'Comments',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Height(height: 12),
                            CommentsList(),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
