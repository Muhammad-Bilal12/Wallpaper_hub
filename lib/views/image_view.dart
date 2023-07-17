import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: kIsWeb
                  ? Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      placeholder: (context, url) => Container(
                        color: const Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (kIsWeb) {
                      _launchURL(widget.imageUrl);
                    } else {
                      _save();
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      Container(
                        width: size.width / 2,
                        height: 50,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white24, width: 1),
                          gradient: const LinearGradient(
                              colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              kIsWeb
                                  ? "Image will open in new tab to download"
                                  : "Image will be saved in gallery",
                              style:
                                  TextStyle(fontSize: 8, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      await Permission.photos.request();
    } else {
      /* PermissionStatus permission = */
      await Permission.storage.request();
    }
  }
}
