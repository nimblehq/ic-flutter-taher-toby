import 'package:flutter/material.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/custom_text_field.dart';
import 'package:collection/collection.dart';

class FormSurveyAnswerTextField extends StatefulWidget {
  final QuestionModel question;
  const FormSurveyAnswerTextField({super.key, required this.question});

  @override
  State<FormSurveyAnswerTextField> createState() =>
      _FormSurveyAnswerTextFieldState();
}

class _FormSurveyAnswerTextFieldState extends State<FormSurveyAnswerTextField> {
  final List<TextEditingController> _controllers = [];
  late List<String> _textFieldHints = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textFieldHints =
        widget.question.answers.map((element) => element.text).toList();
    for (int i = 0; i < _textFieldHints.length; i++) {
      _controllers.add(TextEditingController());
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var textAndControllerPair in IterableZip([
            _textFieldHints,
            _controllers,
          ]))
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacing20),
              child: customTextField(
                context,
                textAndControllerPair[1] as TextEditingController,
                textAndControllerPair[0] as String == 'Email'
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                false,
                textAndControllerPair[0] as String,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
