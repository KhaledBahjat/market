
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/helper/spacing.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, 
    required this.userName,
    required this.time,
    required this.comment,
    required this.rating,
  });

  final String userName;
  final String time;
  final String comment;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Colors.deepPurple.shade100,
            child: Text(
              userName.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ),
          Width(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Height(height: 4),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 16.sp,
                  direction: Axis.horizontal,
                ),
                Height(height: 6),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}