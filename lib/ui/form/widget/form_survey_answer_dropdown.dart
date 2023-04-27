import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerDropdown extends StatefulWidget {
  const FormSurveyAnswerDropdown({super.key});

  @override
  State<FormSurveyAnswerDropdown> createState() =>
      _FormSurveyAnswerDropdownState();
}

class _FormSurveyAnswerDropdownState extends State<FormSurveyAnswerDropdown> {
  late List<String> pickerOptions = [];

  int selectedIndex = 1;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    pickerOptions = [
      AppLocalizations.of(context)!.answer_dropdown_option_very_fullfilled,
      AppLocalizations.of(context)!.answer_dropdown_option_somewhat_fullfilled,
      AppLocalizations.of(context)!
          .answer_dropdown_option_somewhat_unfullfilled,
    ];
    return SizedBox(
      width: AppDimensions.answerDropdownWidth,
      child: Center(
        child: CupertinoPicker(
          scrollController: _scrollController,
          itemExtent: AppDimensions.answerDropdownItemHeight,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: List.generate(
            pickerOptions.length,
            (index) {
              final String item = pickerOptions[index];
              final bool isSelected = selectedIndex == index;
              final selectedTextStyle = Theme.of(context).textTheme.labelMedium;
              final notSelectedTextStyle = Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w400);
              final textStyle =
                  isSelected ? selectedTextStyle : notSelectedTextStyle;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        item,
                        style: textStyle,
                      ),
                    ),
                    if (index + 1 != pickerOptions.length) ...[
                      const Center(
                        child: Divider(
                          color: Colors.white,
                          thickness:
                              AppDimensions.answerDropdownSeparatorThickness,
                        ),
                      )
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
