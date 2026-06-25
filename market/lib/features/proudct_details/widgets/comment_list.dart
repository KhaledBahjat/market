import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/model/product_model.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/proudct_details/widgets/comment_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.product,
  });

  final ProductModel product;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from("comments")
          .stream(primaryKey: ['id'])
          .eq("for_proudct", product.proudctId)
          .order("created_at", ascending: false),

      builder: (context, snapshot) {
        List<Map<String, dynamic>>? comments = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CommentCard(
                  userName: 'User $index,',
                  time: '2 hours ago',
                  comment:
                      'This is a sample comment for product $index. It is very useful and I highly recommend it to everyone!',
                  rating: 4.0,
                ),
              );
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: comments?.length ?? 0,
          );
        }
        return Center(
          child: Text("No comments yet."),
        );
      },
    );
  }
}
