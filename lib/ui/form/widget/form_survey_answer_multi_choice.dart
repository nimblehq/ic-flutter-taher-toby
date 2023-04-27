import 'package:flutter/material.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerMultiChoice extends StatefulWidget {
  final QuestionModel question;

  const FormSurveyAnswerMultiChoice({super.key, required this.question});

  @override
  State<FormSurveyAnswerMultiChoice> createState() =>
      _FormSurveyAnswerMultiChoiceState();
}

class _FormSurveyAnswerMultiChoiceState
    extends State<FormSurveyAnswerMultiChoice> {
  final List<int> _selectedIndexes = [];
  late List<String> _options = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(String title, bool isSelected) {
    final selectedTextStyle = Theme.of(context).textTheme.labelMedium;
    final notSelectedTextStyle = Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(fontWeight: FontWeight.w400);
    final textStyle = isSelected ? selectedTextStyle : notSelectedTextStyle;
    return SizedBox(
      width: MediaQuery.of(context).size.width -
          AppDimensions.answerMultiChoiceMarginLength,
      height: AppDimensions.answerMultiChoiceItemHeight,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textStyle,
              maxLines: 1,
            ),
          ),
          Container(
            width: AppDimensions.answerMultiChoiceCircleSize,
            height: AppDimensions.answerMultiChoiceCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: AppDimensions.answerMultiChoiceCircleBorderWidth,
                color: Colors.white,
              ),
            ),
            child: isSelected
                ? Container(
                    width: AppDimensions.answerMultiChoiceCircleSize,
                    height: AppDimensions.answerMultiChoiceCircleSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const FittedBox(
                      child: Icon(
                        Icons.check,
                        size: AppDimensions.answerMultiChoiceCircleSize,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(String title, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndexes.contains(index)) {
            _selectedIndexes.removeWhere((element) => element == index);
          } else {
            _selectedIndexes.add(index);
            _selectedIndexes.sort();
          }
        });
      },
      child: _buildListItem(title, isSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    _options = widget.question.answers.map((element) => element.text).toList();

    return Center(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Center(
            child: _itemBuilder(
              _options[index],
              _selectedIndexes.contains(index),
              index,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            indent: AppDimensions.answerMultiChoiceDividerIntent,
            endIndent: AppDimensions.answerMultiChoiceDividerIntent,
            color: Colors.white,
            thickness: AppDimensions.answerDropdownSeparatorThickness,
          );
        },
        itemCount: _options.length,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
