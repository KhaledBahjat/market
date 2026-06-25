import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/core/widgets/proudct_list.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, this.query});
  final String? query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: const Text('Search Result'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Height(height: 20),
          ProudctList(
            query: query,
          ),
        ],
      ),
    );
  }
}
