import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/widgets/cousttom_search_feild.dart';
import 'package:market/core/widgets/proudct_list.dart';
import 'package:market/features/home/widgets/categorys_list.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Height(height: 5),
          CustomSearchFeild(
            controller: searchController,
            onPressed: () {
              GoRouter.of(
              context,
            ).pushNamed(AppRouts.searchScreen, extra: searchController.text);
            searchController.clear();
            }
            
          ),
          Height(height: 20),
          Image.asset('assets/imgs/market.jpg', fit: BoxFit.cover),
          Height(height: 20),
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          CategorysList(),
          Height(height: 10),

          Text(
            'Recently Added',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 10),
          ProudctList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
