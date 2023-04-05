import 'package:flutter/material.dart';

class DimmedBackground extends StatelessWidget {
  final String background;
  final double startOpacity;
  final double endOpacity;
  final bool isAsset;

  const DimmedBackground({
    Key? key,
    required this.background,
    this.startOpacity = 0.0,
    this.endOpacity = 0.6,
    this.isAsset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (isAsset) {
      imageProvider = AssetImage(background);
    } else {
      imageProvider = NetworkImage(background);
    }
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(startOpacity),
                Colors.black.withOpacity(endOpacity),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
