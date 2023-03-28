import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/next_button.dart';

const _maxLines = 2;
const _descriptionOpacity = 0.7;

// TODO: Integrate surveys https://github.com/nimblehq/ic-flutter-taher-toby/issues/13
class HomeSurveyPage extends StatelessWidget {
  final VoidCallback onNextButtonPressed;

  const HomeSurveyPage({
    Key? key,
    required this.onNextButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      DimmedBackground(background: Assets.images.dummyBackground.path),
      Padding(
        padding: const EdgeInsets.only(
            left: AppDimensions.spacing20,
            bottom: AppDimensions.spacing54,
            right: AppDimensions.spacing20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  "Career training and development",
                  style: Theme.of(context).textTheme.displayLarge,
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.spacing16),
                Text(
                  "We would like to know what are your goals and skills you wanted to improve this upcoming year.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(_descriptionOpacity)),
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
            ),
            NextButton(
              onNextButtonPressed: onNextButtonPressed,
            ),
          ],
        ),
      ),
    ]);
  }
}
