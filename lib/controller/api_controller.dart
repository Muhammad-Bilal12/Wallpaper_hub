import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/data/api_key.dart';

import 'package:wallpaper_hub/models/wallpaper_model.dart';

getTrendingWallpapers() async {
  List<Photos> wallpapers = [];
  var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=40"),
      headers: {
        "Authorization": APIKEY,
      });

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var data = WallpaperModel.fromJson(json);
    wallpapers = data.photos!;
    print(data.photos![0].src!.portrait);
    return wallpapers;
  }
}

getCategoryWallpapers(String category) async {
  List<Photos> wallpapers = [];
  var response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$category&per_page=30&page=1"),
      headers: {
        "Authorization": APIKEY,
      });

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var data = WallpaperModel.fromJson(json);
    wallpapers = data.photos!;
    print(data.photos![0].src!.portrait);
    return wallpapers;
  }
}
