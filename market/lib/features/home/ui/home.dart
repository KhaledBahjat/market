import 'package:flutter/material.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
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
          Height(height: 20),
          Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/imgs/sale.jpg', fit: BoxFit.cover),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.black54,
                        child: const Text(
                          'Big Sale',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

