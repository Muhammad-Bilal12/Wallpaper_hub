import 'package:flutter/material.dart';

import '../models/categories_model.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final CategoriesModel category;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            category.imageUrl,
            width: 100,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 100,
          height: 50,
          margin: const EdgeInsets.only(right: 16),
          alignment: Alignment.center,
          child: Text(
            category.cotegoryName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
