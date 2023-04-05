import 'package:flutter/material.dart';

class DimmedBackground extends StatelessWidget {
  final String background;
  final double startOpacity;
  final double endOpacity;

  const DimmedBackground({
    Key? key,
    required this.background,
    this.startOpacity = 0.0,
    this.endOpacity = 0.6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(background),
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
