import 'package:flutter/material.dart';
import 'package:flutter_survey/main.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_dropdown.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_emoji.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_multi_choice.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_nps.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_text_field.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_textarea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_survey/constant/widget_keys.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_survey/database/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await configureLocalStorage();
  await configureDependencyInjection();

  testWidgets('Login error test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: SurveyApp(),
    ));
    await tester.pumpAndSettle();
    final finder = find.byKey(const Key(WidgetKeys.emailTextFieldKey));
    await tester.tap(finder);
    await tester.pumpAndSettle();
    String emailValue = 'abcd@gmail.com';
    await tester.enterText(finder, emailValue);

    final passwordFinder =
        find.byKey(const Key(WidgetKeys.passwordTextFieldKey));
    await tester.tap(finder);
    await tester.pumpAndSettle();
    String passwordValue = '123456789';
    await tester.enterText(passwordFinder, passwordValue);

    final loginButtonFinder = find.byKey(const Key(WidgetKeys.loginButtonKey));
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text('Bad request'), findsOneWidget);
  });

  testWidgets('Complete survey test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: SurveyApp(),
    ));
    await tester.pumpAndSettle();
    await _assertLoginScreen(tester);
    await _assertHomeScreen(tester);
    await _assertFormScreen(tester);
  });
}

Future<void> _assertLoginScreen(WidgetTester tester) async {
  final finder = find.byKey(const Key(WidgetKeys.emailTextFieldKey));
  await tester.tap(finder);
  await tester.pumpAndSettle();
  String emailValue = 'kaung@nimblehq.co';
  await tester.enterText(finder, emailValue);

  final passwordFinder = find.byKey(const Key(WidgetKeys.passwordTextFieldKey));
  await tester.tap(finder);
  await tester.pumpAndSettle();
  String passwordValue = '12345678';
  await tester.enterText(passwordFinder, passwordValue);

  final loginButtonFinder = find.byKey(const Key(WidgetKeys.loginButtonKey));
  await tester.tap(loginButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _assertHomeScreen(WidgetTester tester) async {
  String homeScreenTextValue = 'Today';
  expect(find.text(homeScreenTextValue), findsOneWidget);

  String firstSurveyTitleText = 'Scarlett Bangkok';
  expect(find.text(firstSurveyTitleText), findsOneWidget);

  await tester.flingFrom(const Offset(100, 300), const Offset(-100, 0), 500);
  await tester.pumpAndSettle();

  String secondSurveyTitleText = 'ibis Bangkok Riverside';
  expect(find.text(secondSurveyTitleText), findsOneWidget);

  final nextButtonFinder = find.byKey(const Key(WidgetKeys.nextButtonKey));
  expect(nextButtonFinder, findsOneWidget);
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  final startSurveyButtonFinder =
      find.byKey(const Key(WidgetKeys.startSurveyButtonKey));
  expect(startSurveyButtonFinder, findsOneWidget);
  await tester.tap(startSurveyButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _assertFormScreen(WidgetTester tester) async {
  final nextButtonFinder = find.byKey(const Key(WidgetKeys.nextButtonKey));
  expect(nextButtonFinder, findsOneWidget);

  // multi-choice
  final multiChoiceFinder = find.byType(FormSurveyAnswerMultiChoice);
  final multiChoiceCenter = tester.getCenter(multiChoiceFinder);
  final multiChoiceOffset =
      Offset(multiChoiceCenter.dx, multiChoiceCenter.dy + 100.0);
  await tester.tapAt(multiChoiceOffset);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // multi-choice
  final multiChoiceFinder2 = find.byType(FormSurveyAnswerMultiChoice);
  final multiChoiceCenter2 = tester.getCenter(multiChoiceFinder2);
  final multiChoiceOffset2 =
      Offset(multiChoiceCenter2.dx, multiChoiceCenter2.dy);
  await tester.tapAt(multiChoiceOffset2);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // NPS
  final npsFinder = find.byType(FormSurveyAnswerNps);
  final npsCenter = tester.getCenter(npsFinder);
  final npsOffset = Offset(npsCenter.dx - 100.0, npsCenter.dy);
  await tester.tapAt(npsOffset);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // star
  final emojiAnswerFinder = find.byType(FormSurveyAnswerEmoji);
  final emojiAnswerCenter = tester.getCenter(emojiAnswerFinder);
  final emojiAnswerOffset =
      Offset(emojiAnswerCenter.dx + 60.0, emojiAnswerCenter.dy);
  await tester.tapAt(emojiAnswerOffset);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // star
  final emojiAnswerFinder2 = find.byType(FormSurveyAnswerEmoji);
  final emojiAnswerCenter2 = tester.getCenter(emojiAnswerFinder2);
  final emojiAnswerOffset2 =
      Offset(emojiAnswerCenter2.dx - 60.0, emojiAnswerCenter2.dy);
  await tester.tapAt(emojiAnswerOffset2);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // star
  final emojiAnswerFinder3 = find.byType(FormSurveyAnswerEmoji);
  final emojiAnswerCenter3 = tester.getCenter(emojiAnswerFinder3);
  final emojiAnswerOffset3 =
      Offset(emojiAnswerCenter3.dx - 100.0, emojiAnswerCenter3.dy);
  await tester.tapAt(emojiAnswerOffset3);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // star
  final emojiAnswerFinder4 = find.byType(FormSurveyAnswerEmoji);
  final emojiAnswerCenter4 = tester.getCenter(emojiAnswerFinder4);
  final emojiAnswerOffset4 =
      Offset(emojiAnswerCenter4.dx + 100.0, emojiAnswerCenter4.dy);
  await tester.tapAt(emojiAnswerOffset4);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // text-area
  final textAreaFinder = find.byType(FormSurveyAnswerTextarea);
  await tester.enterText(textAreaFinder, 'Great hotel!');
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // dropdown
  final dropdownAnswerFinder = find.byType(FormSurveyAnswerDropdown);
  final dropdownAnswerCenter = tester.getCenter(dropdownAnswerFinder);
  final dropdownAnswerFromOffset =
      Offset(dropdownAnswerCenter.dx, dropdownAnswerCenter.dy);
  final dropdownAnswerToOffset =
      Offset(dropdownAnswerCenter.dx, dropdownAnswerCenter.dy - 200);
  await tester.flingFrom(dropdownAnswerFromOffset, dropdownAnswerToOffset, 500);
  await tester.pumpAndSettle();
  await tester.tap(nextButtonFinder);
  await tester.pumpAndSettle();

  // text-fields
  final textField1 = find.byType(TextField).at(0);
  await tester.enterText(textField1, 'My first name');
  await tester.pumpAndSettle();
  final textField2 = find.byType(TextField).at(1);
  await tester.enterText(textField2, 'My mobile number');
  await tester.pumpAndSettle();

  final submitSurveyButtonFinder =
      find.byKey(const Key(WidgetKeys.submitSurveyButtonKey));
  await tester.tap(submitSurveyButtonFinder);
  await tester.pumpAndSettle();

  String thankYouMessage =
      'Thank you for taking the time to complete the survey.\nWe hope to welcome you back to ibis Bangkok Riverside soon!';
  expect(find.text(thankYouMessage), findsOneWidget);
}
