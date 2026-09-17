import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/constant.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/networke/cache/shared_prefs.dart';
import 'package:market/core/proudct_model/proudct_model.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/widgets/coustom_text_form_feild.dart';
import 'package:market/features/proudct_details/logic/cubit/proudct_details_cubit.dart';
import 'package:market/features/proudct_details/widgets/comment_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProudctDetils extends StatefulWidget {
  const ProudctDetils({super.key, required this.proudctModel});
  final ProudctModel proudctModel;

  @override
  State<ProudctDetils> createState() => _ProudctDetilsState();
}

class _ProudctDetilsState extends State<ProudctDetils> {
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProudctDetailsCubit()
        ..getUserRateForSpecificProduct(productId: widget.proudctModel.id!)
        ..getCommentsForSpecificProduct(productId: widget.proudctModel.id!),
      child: BlocBuilder<ProudctDetailsCubit, ProudctDetailsState>(
        builder: (context, state) {
          ProudctDetailsCubit cubit = context.read<ProudctDetailsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.proudctModel.proudctName ?? 'Proudct Name'),
              centerTitle: true,
            ),
            body: Skeletonizer(
              enabled: state is GetRatesLoading || state is GetCommentLoading,
              child: ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        widget.proudctModel.imageUrls ??
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
                              widget.proudctModel.proudctName ?? 'Proudct Name',
                            ),
                            Text(
                              '${widget.proudctModel.proudctPrice ?? 120}\$',
                            ),
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
                          widget.proudctModel.proudctDesc ??
                              'Proudct Description',
                        ),
                        Height(height: 20),
                        Skeletonizer(
                          enabled: state is AddOrUpdateRateLoading,
                          child: RatingBar.builder(
                            initialRating: cubit.userRate.toDouble(),
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
                              cubit.addOrUpdateRateForSpecificProduct(
                                productId: widget.proudctModel.id!,
                                data: {
                                  'for_user': cubit.usrId,
                                  'for_proudct': widget.proudctModel.id!,
                                  'rate': rating.toInt(),
                                },
                              );
                            },
                          ),
                        ),
                        Height(height: 16),
                        Form(
                          key: _formKey,
                          child: CustomTextFormFeild(
                            hint: "Type your feedback",
                            controller: commentController,
                            labelText: "Type your feedback",
                            autovalidateMode: _autoValidateMode,
                            suffixIcon: state is AddCommentLoading
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.kBlackColor,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        setState(() {
                                          _autoValidateMode = AutovalidateMode
                                              .onUserInteractionIfError;
                                        });
                                        return;
                                      }

                                      await cubit.addUserComment(
                                        proudctId: widget.proudctModel.id!,
                                        data: {
                                          'user_name':
                                              SharedPrefs.getString(
                                                AppKeys.userName,
                                              ) ??
                                              'User',
                                          'for_user': cubit.usrId,
                                          'for_proudct':
                                              widget.proudctModel.id!,
                                          'comment': commentController.text
                                              .trim(),
                                        },
                                      );
                                      commentController.clear();
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
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
                        CommentsList(comments: cubit.comments),
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

  @override
  void dispose() {
    // TODO: implement dispose
    commentController.dispose();
    super.dispose();
  }
}
