import 'package:flutter/material.dart';
import 'package:wallpaper_hub/controller/api_controller.dart';
import 'package:wallpaper_hub/views/categories_screen.dart';

import '../models/categories_model.dart';
import '../widgets/brand_name.dart';
import 'package:wallpaper_hub/data/data.dart';

import '../widgets/category_tile.dart';
import '../widgets/grid_wallpapers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<CategoriesModel> category = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    category = categories;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xfff5f8fd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                CategoriesScreen(name: _searchController.text),
                          ),
                        );
                      },
                      child: const Icon(Icons.search)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesScreen(
                                name: category[index].cotegoryName),
                          ));
                    },
                    child: CategoryTile(
                      category: category[index],
                    ),
                  );
                },
              ),
            ),
            FutureBuilder(
                future: getTrendingWallpapers(),
                builder: (ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: GridWallpapers(data: snapshot.data),
                      // child: GridView.builder(
                      //     itemCount: snapshot.data.length,
                      //     padding: const EdgeInsets.symmetric(horizontal: 16),
                      //     physics: const ClampingScrollPhysics(),
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2,
                      //       mainAxisSpacing: 6.0,
                      //       crossAxisSpacing: 6.0,
                      //       childAspectRatio: 0.6,
                      //     ),
                      //     itemBuilder: (ctx, index) {
                      //       return ClipRRect(
                      //         borderRadius: BorderRadius.circular(16),
                      //         child: Image.network(
                      //           snapshot.data[index].src.portrait,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       );
                      //     }),
                    );
                  }
                  return Container(
                    color: Colors.red,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
