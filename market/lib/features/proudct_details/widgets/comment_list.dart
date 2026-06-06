import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/features/proudct_details/widgets/comment_card.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      itemCount: 5,
    );
  }
}

