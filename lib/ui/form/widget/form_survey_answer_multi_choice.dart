import 'package:flutter/material.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/model/submit_answer_model.dart';

class FormSurveyAnswerMultiChoice extends StatefulWidget {
  final ValueChanged<List<SubmitAnswerModel>> onUpdateAnswer;
  final QuestionModel question;

  const FormSurveyAnswerMultiChoice({
    super.key,
    required this.question,
    required this.onUpdateAnswer,
  });

  @override
  State<FormSurveyAnswerMultiChoice> createState() =>
      _FormSurveyAnswerMultiChoiceState();
}

class _FormSurveyAnswerMultiChoiceState
    extends State<FormSurveyAnswerMultiChoice> {
  final List<SubmitAnswerModel> _selectedAnswers = [];
  late List<SubmitAnswerModel> _options = [];

  @override
  void initState() {
    super.initState();
    _options = widget.question.answers
        .map((element) => SubmitAnswerModel(
              answerId: element.id,
              answerText: element.text,
            ))
        .toList();
    final index = (_options.length / 2).round();
    _selectedAnswers.add(_options[index]);
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
          if (_selectedAnswers.contains(_options[index])) {
            _selectedAnswers.remove(_options[index]);
          } else {
            _selectedAnswers.add(_options[index]);
          }
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
              _options[index].answerText ?? '',
              _selectedAnswers.contains(_options[index]),
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
        itemCount: _options.length,
      ),
    );
  }
}
