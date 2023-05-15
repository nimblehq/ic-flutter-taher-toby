import 'package:flutter/material.dart';
import 'package:flutter_survey/main.dart';
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

  final nextButton = find.byKey(const Key(WidgetKeys.nextButtonKey));
  expect(nextButton, findsOneWidget);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();

  final startSurveyButtonFinder =
      find.byKey(const Key(WidgetKeys.startSurveyButtonKey));
  expect(startSurveyButtonFinder, findsOneWidget);
}

Future<void> _assertFormScreen(WidgetTester tester) async {
  final nextButton = find.byKey(const Key(WidgetKeys.nextButtonKey));
  expect(nextButton, findsOneWidget);
  // star
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // star
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // star
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // star
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // heart
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // emoji
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // multi-choice
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // NPS
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // text-area
  await tester.enterText(find.byType(TextField), 'Great hotel!');
  await tester.pumpAndSettle();
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  // text-fields
  await tester.enterText(find.byType(TextField).at(0), 'My first name');
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).at(1), 'My mobile number');
  await tester.pumpAndSettle();

  final submitSurveyButton =
      find.byKey(const Key(WidgetKeys.submitSurveyButtonKey));
  await tester.tap(submitSurveyButton);
  await tester.pumpAndSettle();
}
