import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProudctDetils extends StatelessWidget {
  const ProudctDetils({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proudct Name'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYh3jq9ASNY0osM-0jk_V1RGFQGjfRpmo9fQ&s',
            width: double.infinity,
            height: 250.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
