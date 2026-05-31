import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
            Center(
              child: const Text(
              'Your Favorite Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
            ),
          Height(height: 20),
          ProudctList()
        ],
      ),
    );
  }
}