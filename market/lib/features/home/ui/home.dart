import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          CustomSearchFeild(),
          Height(height: 20),
          Image.asset('assets/imgs/market.jpg', fit: BoxFit.cover),
          Height(height: 20),
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          CategorysList(),
          Text('Recently Added', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Height(height: 10),
          ProudctList()
        ],
      ),
    );
  }
}



