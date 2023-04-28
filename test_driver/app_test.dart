import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login Screen Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('verify the email hint text on login screen', () async {
      SerializableFinder text = find.text('Email');
      await driver.waitFor(text);
      expect(await driver.getText(text), 'Email');
    });

    test('verify the password hint text on login screen', () async {
      SerializableFinder text = find.text('Password');
      await driver.waitFor(text);
      expect(await driver.getText(text), 'Password');
    });

    test('verify the text on login button', () async {
      final buttonFinder = find.text('Log in');
      expect(await driver.getText(buttonFinder), 'Log in');
    });

    test(
      'verify the text input in textfields',
      () async {
        String emailValue = 'abcd@gmail.com';
        SerializableFinder emailTextField =
            find.byValueKey('emailTextFieldKey');
        await driver.waitFor(emailTextField);
        await driver.tap(emailTextField);
        await driver.enterText(emailValue);
        SerializableFinder emailText = find.text(emailValue);
        await driver.waitFor(emailText);
        expect(await driver.getText(emailText), emailValue);

        String passwordValue = '12345678910';
        SerializableFinder passwordTextField =
            find.byValueKey('passwordTextFieldKey');
        await driver.waitFor(passwordTextField);
        await driver.tap(passwordTextField);
        await driver.enterText(passwordValue);
        SerializableFinder passwordText = find.text(passwordValue);
        await driver.waitFor(passwordText);
        expect(await driver.getText(passwordText), passwordValue);
      },
      timeout: const Timeout(
        Duration(minutes: 2),
      ),
    );

    test(
      'verify login error message',
      () async {
        String emailValue = 'abcd@gmail.com';
        SerializableFinder emailTextField =
            find.byValueKey('emailTextFieldKey');
        await driver.waitFor(emailTextField);
        await driver.tap(emailTextField);
        await driver.enterText(emailValue);
        SerializableFinder emailText = find.text(emailValue);
        await driver.waitFor(emailText);

        String passwordValue = '12345678910';
        SerializableFinder passwordTextField =
            find.byValueKey('passwordTextFieldKey');
        await driver.waitFor(passwordTextField);
        await driver.tap(passwordTextField);
        await driver.enterText(passwordValue);
        SerializableFinder passwordText = find.text(passwordValue);
        await driver.waitFor(passwordText);

        SerializableFinder loginButton = find.byValueKey('loginButtonKey');
        await driver.waitFor(loginButton);
        await driver.tap(loginButton);

        String errorMessage = 'Bad request';
        SerializableFinder loginErrorText = find.text(errorMessage);
        await driver.waitFor(loginErrorText);
        expect(await driver.getText(loginErrorText), errorMessage);
      },
      timeout: const Timeout(
        Duration(minutes: 2),
      ),
    );

    test(
      'verify login success and navigate to home screen',
      () async {
        String emailValue = 'kaung@nimblehq.co';
        SerializableFinder emailTextField =
            find.byValueKey('emailTextFieldKey');
        await driver.waitFor(emailTextField);
        await driver.tap(emailTextField);
        await driver.enterText(emailValue);
        SerializableFinder emailText = find.text(emailValue);
        await driver.waitFor(emailText);

        String passwordValue = '12345678';
        SerializableFinder passwordTextField =
            find.byValueKey('passwordTextFieldKey');
        await driver.waitFor(passwordTextField);
        await driver.tap(passwordTextField);
        await driver.enterText(passwordValue);
        SerializableFinder passwordText = find.text(passwordValue);
        await driver.waitFor(passwordText);

        SerializableFinder loginButton = find.byValueKey('loginButtonKey');
        await driver.waitFor(loginButton);
        await driver.tap(loginButton);

        String homeScreenTextValue = 'Today';
        SerializableFinder homeScreenText = find.text(homeScreenTextValue);
        await driver.waitFor(homeScreenText);
        expect(await driver.getText(homeScreenText), homeScreenTextValue);
      },
      timeout: const Timeout(
        Duration(minutes: 3),
      ),
    );
  });
}
