import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onNextButtonPressed;

  const NextButton({
    Key? key,
    required this.onNextButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.spacing16),
      child: FloatingActionButton(
        onPressed: onNextButtonPressed,
        backgroundColor: Colors.white,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
