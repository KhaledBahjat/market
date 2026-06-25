import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/proudct_list.dart';

class CategoryResult extends StatelessWidget {
  const CategoryResult({super.key,required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(category),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Height(height: 20),
          ProudctList(
            category: category,
          ),
        ],
      ),
    );
  }
}
