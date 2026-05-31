import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
            Center(
              child: const Text(
              'Welcome to our store!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
            ),
            Height(height: 10),
          CustomSearchFeild(),
          Height(height: 20),
          ProudctList()
        ],
      ),
    );
  }
}