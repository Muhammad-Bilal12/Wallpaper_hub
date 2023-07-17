import "package:flutter/material.dart";

class BrandName extends StatelessWidget {
  const BrandName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Wallpaper",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Text(
          "Hub",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
