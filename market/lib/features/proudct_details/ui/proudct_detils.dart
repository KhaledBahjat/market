
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
  const ProudctDetils({
    super.key,
    required this.proudctModel,
  });

  final ProudctModel proudctModel;

  @override
  State<ProudctDetils> createState() => _ProudctDetilsState();
}

class _ProudctDetilsState extends State<ProudctDetils> {
  final TextEditingController commentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProudctDetailsCubit()
        ..getUserRateForSpecificProduct(
          productId: widget.proudctModel.id!,
        )
        ..getCommentsForSpecificProduct(
          productId: widget.proudctModel.id!,
        ),
      child: BlocBuilder<ProudctDetailsCubit, ProudctDetailsState>(
        builder: (context, state) {
          final ProudctDetailsCubit cubit =
              context.read<ProudctDetailsCubit>();

          final bool isLoading =
              state is GetRatesLoading || state is GetCommentLoading;

          return Scaffold(
            backgroundColor: Colors.grey.shade50,

            // =========================================================
            // APP BAR
            // =========================================================
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade50,
              surfaceTintColor: Colors.transparent,

              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),

              title: Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              centerTitle: true,

              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.kPrimaryColor
                          : Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),

            // =========================================================
            // BODY
            // =========================================================
            body: Skeletonizer(
              enabled: isLoading,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 110.h),
                children: [
                  _buildProductImage(),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Height(height: 18),

                        // =================================================
                        // PRODUCT NAME
                        // =================================================
                        Text(
                          widget.proudctModel.proudctName ??
                              'Product Name',
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),

                        Height(height: 10),

                        // =================================================
                        // RATING + PRICE
                        // =================================================
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildRatingSummary(cubit),

                            Text(
                              '${widget.proudctModel.proudctPrice ?? 120}\$',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),

                        Height(height: 22),

                        // =================================================
                        // DESCRIPTION
                        // =================================================
                        _buildDescription(),

                        Height(height: 22),

                        // =================================================
                        // USER RATING
                        // =================================================
                        _buildRatingSection(
                          context,
                          cubit,
                          state,
                        ),

                        Height(height: 24),

                        // =================================================
                        // COMMENT SECTION
                        // =================================================
                        _buildCommentSection(
                          context,
                          cubit,
                          state,
                        ),

                        Height(height: 25),

                        // =================================================
                        // COMMENTS HEADER
                        // =================================================
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer Reviews',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (cubit.comments.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor
                                      .withOpacity(.10),
                                  borderRadius:
                                      BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '${cubit.comments.length}',
                                  style: TextStyle(
                                    color:
                                        AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        Height(height: 14),

                        // =================================================
                        // COMMENTS LIST
                        // =================================================
                        if (cubit.comments.isEmpty)
                          _buildEmptyComments()
                        else
                          CommentsList(
                            comments: cubit.comments,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ===========================================================
            // BOTTOM CART BAR
            // ===========================================================
            bottomNavigationBar: _buildBottomBar(),
          );
        },
      ),
    );
  }

  // =====================================================================
  // PRODUCT IMAGE
  // =====================================================================

  Widget _buildProductImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Hero(
        tag: 'product-image-${widget.proudctModel.id}',
        child: Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.07),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: CachedNetworkImage(
              imageUrl: widget.proudctModel.imageUrls ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
              fit: BoxFit.cover,

              placeholder: (context, url) {
                return Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },

              errorWidget: (context, url, error) {
                return Container(
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50.sp,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================================
  // RATING SUMMARY
  // =====================================================================

  Widget _buildRatingSummary(
    ProudctDetailsCubit cubit,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: 22,
          ),

          SizedBox(width: 5.w),

          Text(
            cubit.averageRate.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(width: 5.w),

          Text(
            'Rating',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // DESCRIPTION
  // =====================================================================

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          Height(height: 10),

          Text(
            widget.proudctModel.proudctDesc ??
                'Product Description',
            style: TextStyle(
              fontSize: 14.5.sp,
              height: 1.65,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // RATING SECTION
  // =====================================================================

  Widget _buildRatingSection(
    BuildContext context,
    ProudctDetailsCubit cubit,
    ProudctDetailsState state,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rate this product',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          Height(height: 5),

          Text(
            'How would you rate your experience?',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),

          Height(height: 15),

          Center(
            child: Skeletonizer(
              enabled: state is AddOrUpdateRateLoading,
              child: RatingBar.builder(
                initialRating: cubit.userRate.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 35.w,
                itemPadding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  cubit.addOrUpdateRateForSpecificProduct(
                    productId: widget.proudctModel.id!,
                    data: {
                      'for_user': cubit.usrId,
                      'for_proudct':
                          widget.proudctModel.id!,
                      'rate': rating.toInt(),
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // COMMENT SECTION
  // =====================================================================

  Widget _buildCommentSection(
    BuildContext context,
    ProudctDetailsCubit cubit,
    ProudctDetailsState state,
  ) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: CustomTextFormFeild(
          hint: 'Share your experience...',
          controller: commentController,
          labelText: 'Write a review',
          autovalidateMode: _autoValidateMode,

          suffixIcon: state is AddCommentLoading
              ? Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        setState(() {
                          _autoValidateMode =
                              AutovalidateMode
                                  .onUserInteractionIfError;
                        });
                        return;
                      }

                      await cubit.addUserComment(
                        proudctId:
                            widget.proudctModel.id!,
                        data: {
                          'user_name':
                              SharedPrefs.getString(
                                    AppKeys.userName,
                                  ) ??
                                  'User',
                          'for_user': cubit.usrId,
                          'for_proudct':
                              widget.proudctModel.id!,
                          'comment':
                              commentController.text.trim(),
                        },
                      );

                      commentController.clear();

                      setState(() {
                        _autoValidateMode =
                            AutovalidateMode.disabled;
                      });
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // =====================================================================
  // EMPTY COMMENTS
  // =====================================================================

  Widget _buildEmptyComments() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 35.h,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Container(
            width: 65.w,
            height: 65.w,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 30.sp,
              color: AppColors.kPrimaryColor,
            ),
          ),

          Height(height: 12),

          Text(
            'No reviews yet',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          Height(height: 5),

          Text(
            'Be the first one to share your experience.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // BOTTOM BAR
  // =====================================================================

  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          18.w,
          12.h,
          18.w,
          12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withOpacity(.10),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.kPrimaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // DISPOSE
  // =====================================================================

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
