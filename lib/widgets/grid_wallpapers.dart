import 'package:flutter/material.dart';
import 'package:wallpaper_hub/views/image_view.dart';

class GridWallpapers extends StatelessWidget {
  const GridWallpapers({super.key, required this.data});

  final data;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      ImageView(imageUrl: data[index].src.portrait),
                ),
              );
            },
            child: Hero(
              tag: data[index].src.portrait,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  data[index].src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}
