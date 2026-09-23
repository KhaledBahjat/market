
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/core/widgets/proudct_list.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        surfaceTintColor: Colors.transparent,

        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: true,

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
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(
          top: 12.h,
        ),
        child: ProudctList(
          categoryName: categoryName,
        ),
      ),
    );
  }
}