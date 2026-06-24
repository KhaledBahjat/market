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
import 'package:market/features/auth/logic/cubit/auth_cubit.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/proudct_details/logic/cubit/product_details_cubit.dart';
import 'package:market/features/proudct_details/widgets/comment_list.dart';

class ProudctDetils extends StatefulWidget {
   ProudctDetils({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProudctDetils> createState() => _ProudctDetilsState();
}

class _ProudctDetilsState extends State<ProudctDetils> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getProductRates(productId: widget.product.proudctId),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if(state is AddOrUpdateUserRateSuccess){
            GoRouter.of(context).pushReplacementNamed(
              AppRouts.proudctDetails,
              extra: widget.product,
            );
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit=context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.product.proudctName),
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
                            widget.product.imageUrl ??
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
                                Text(widget.product.proudctName),
                                Text('${widget.product.proudctPrice}\$'),
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

                            Text(widget.product.desc),
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
                                  productId: widget.product.proudctId,
                                  rateData: {
                                    "for_user": cubit.userId,
                                    "for_product": widget.product.proudctId,
                                    "rate": rating.toInt(),
                                    "user_name": context.read<AuthCubit>().userData?.name ?? ''
                                  },
                                );
                              },
                            ),
                            Height(height: 16),
                            CustomTextFormFeild(
                              hint: 'Type your feedback',
                              controller: commentController,
                              labelText: 'Type your feedback',
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final comment = commentController.text.trim();
                                  if (comment.isEmpty) {
                                    return;
                                  }
                                  await cubit.addComment(
                                    data: {
                                      "for_user": cubit.userId,
                                      "for_proudct": widget.product.proudctId,
                                      "comment": comment,
                                      "user_name": context.read<AuthCubit>().userData?.name?? ''
                                    },
                                  );
                                  if (!context.mounted) {
                                    return;
                                  }
                                  commentController.clear();
                                },
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
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
