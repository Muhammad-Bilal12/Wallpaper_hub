import 'package:flutter/material.dart';
import 'package:wallpaper_hub/controller/api_controller.dart';

import '../widgets/grid_wallpapers.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: FutureBuilder(
        future: getCategoryWallpapers(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return GridWallpapers(data: snapshot.data);
          }
          return Container();
        },
      ),
    );
  }
}
