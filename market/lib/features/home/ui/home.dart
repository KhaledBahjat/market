import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';

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
          Image.asset('assets/imgs/market.jpg',fit: BoxFit.cover,),
        ],
      ),
    );
  }
}

