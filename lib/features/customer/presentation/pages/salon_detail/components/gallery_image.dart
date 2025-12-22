import 'package:flutter/material.dart';

class GalleryImage extends StatelessWidget {
  const GalleryImage({super.key, required this.image, required this.height});

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
