import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/proudct_details/logic/cubit/get_rates_cubit.dart';
import 'package:market/features/proudct_details/widgets/comment_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProudctDetils extends StatelessWidget {
  const ProudctDetils({super.key, required this.proudctModel});
  final ProudctModel proudctModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetRatesCubit()
            ..getUserRateForSpecificProduct(productId: proudctModel.id!),
      child: BlocBuilder<GetRatesCubit, GetRatesState>(
        builder: (context, state) {
          GetRatesCubit cubit = context.read<GetRatesCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(proudctModel.proudctName ?? 'Proudct Name'),
              centerTitle: true,
            ),
            body: Skeletonizer(
              enabled: state is GetRatesLoading,
              child: ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        proudctModel.imageUrls ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
                    width: double.infinity,
                    height: 250.h,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              proudctModel.proudctName ?? 'Proudct Name',
                            ),
                            Text('${proudctModel.proudctPrice ?? 120}\$'),
                          ],
                        ),
                        Height(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${cubit.averageRate}',
                                ),
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

                        Text(
                          proudctModel.proudctDesc ?? 'Proudct Description',
                        ),
                        Height(height: 20),
                        RatingBar.builder(
                          initialRating: 3,
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
                            log(rating.toString());
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
            ),
          );
        },
      ),
    );
  }
}
