import 'package:flutter/material.dart';
import 'package:market/core/widgets/proudct_card.dart';

class ProudctList extends StatelessWidget {
  const ProudctList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with actual item count
      itemBuilder: (context, index) => ProudctCard(),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}