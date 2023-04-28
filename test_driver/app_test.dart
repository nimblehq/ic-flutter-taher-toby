import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home Screen Test', () {
    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });
    tearDownAll(() async {
      driver.close();
    });
    test('verify the text on login screen', () async {
      SerializableFinder message = find.text("Email");
      await driver.waitFor(message);
      expect(await driver.getText(message), "Email");
    });

    test('verify the text on login button', () async {
      final buttonFinder = find.text('Log in');
      expect(await driver.getText(buttonFinder), 'Log in');
    });
  });
}
