import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerDropdown extends StatefulWidget {
  final QuestionModel question;

  const FormSurveyAnswerDropdown({super.key, required this.question});

  @override
  State<FormSurveyAnswerDropdown> createState() =>
      _FormSurveyAnswerDropdownState();
}

class _FormSurveyAnswerDropdownState extends State<FormSurveyAnswerDropdown> {
  late List<String> _pickerOptions = [];

  int _selectedIndex = 1;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _pickerOptions =
        widget.question.answers.map((element) => element.text).toList();
    _selectedIndex = (_pickerOptions.length / 2).round();
    _scrollController =
        FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.answerDropdownWidth,
      child: Center(
        child: CupertinoPicker(
          scrollController: _scrollController,
          itemExtent: AppDimensions.answerDropdownItemHeight,
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: List.generate(
            _pickerOptions.length,
            (index) {
              final String item = _pickerOptions[index];
              final bool isSelected = _selectedIndex == index;
              final selectedTextStyle = Theme.of(context).textTheme.labelMedium;
              final unSelectedTextStyle = Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w400);
              final textStyle =
                  isSelected ? selectedTextStyle : unSelectedTextStyle;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.spacing10,
                    ),
                    child: Text(
                      item,
                      style: textStyle,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (index + 1 != _pickerOptions.length) ...[
                    const Divider(
                      color: Colors.white,
                      thickness: AppDimensions.answerDropdownSeparatorThickness,
                    ),
                  ],
                ],
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
