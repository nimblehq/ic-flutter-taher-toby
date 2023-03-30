import 'package:flutter/material.dart';

const _startOpacity = 0.0;
const _endOpacity = 0.6;

class DimmedBackground extends StatelessWidget {
  final String background;

  const DimmedBackground({
    Key? key,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(background),
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
                Colors.black.withOpacity(_startOpacity),
                Colors.black.withOpacity(_endOpacity),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
