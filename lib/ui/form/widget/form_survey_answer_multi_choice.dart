import 'package:flutter/material.dart';
import 'package:flutter_survey/model/answer_model.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerMultiChoice extends StatefulWidget {
  final ValueChanged<List<SubmitSurveyAnswerModel>> onUpdateAnswer;
  final List<AnswerModel> answers;

  const FormSurveyAnswerMultiChoice({
    super.key,
    required this.answers,
    required this.onUpdateAnswer,
  });

  @override
  State<FormSurveyAnswerMultiChoice> createState() =>
      _FormSurveyAnswerMultiChoiceState();
}

class _FormSurveyAnswerMultiChoiceState
    extends State<FormSurveyAnswerMultiChoice> {
  late List<SubmitSurveyAnswerModel> _selectedAnswers;
  final List<int> _selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    final index = (widget.answers.length / 2).round();
    _selectedAnswers = [SubmitSurveyAnswerModel(id: widget.answers[index].id)];
    _selectedIndexes.add(index);
    widget.onUpdateAnswer(_selectedAnswers);
  }

  Widget _buildListItem(String title, bool isSelected) {
    final selectedTextStyle = Theme.of(context).textTheme.labelMedium;
    final unSelectedTextStyle = Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(fontWeight: FontWeight.w400);
    final textStyle = isSelected ? selectedTextStyle : unSelectedTextStyle;
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
              overflow: TextOverflow.ellipsis,
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

  Widget _buildItems(String title, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndexes.contains(index)) {
            _selectedIndexes.remove(index);
          } else {
            _selectedIndexes.add(index);
          }
          _selectedAnswers = _selectedIndexes
              .map(
                (index) => SubmitSurveyAnswerModel(
                  id: widget.answers[index].id,
                ),
              )
              .toList();
          widget.onUpdateAnswer(_selectedAnswers);
        });
      },
      child: _buildListItem(title, isSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemBuilder: (_, index) {
          return Center(
            child: _buildItems(
              widget.answers[index].text,
              _selectedIndexes.contains(index),
              index,
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(
            indent: AppDimensions.answerMultiChoiceDividerIndent,
            endIndent: AppDimensions.answerMultiChoiceDividerIndent,
            color: Colors.white,
            thickness: AppDimensions.answerDropdownSeparatorThickness,
          );
        },
        itemCount: widget.answers.length,
      ),
    );
  }
}
