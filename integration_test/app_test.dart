import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_survey/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_survey/constant/widget_keys.dart';
import 'package:flutter_survey/di/di.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await configureDependencyInjection();
  testWidgets('Login screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const SurveyApp());
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

    expect(find.text('Bad request'), findsOneWidget);
  });
}
