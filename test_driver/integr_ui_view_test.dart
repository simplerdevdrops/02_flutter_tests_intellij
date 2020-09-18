import 'package:test/test.dart';

//FLUTTER-DRIVER IMPORT:
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('Group CI-CD-01: Integration UI/VIEW Test - View.Dart', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    //FLUTTER-DRIVER ONLY "WORKS WELL/PROPERLY" WITH 'BY_VALUE_KEY'
    var _textField = find.byValueKey("input");
    var _button = find.byValueKey("button");
    var _resultLabel = find.byValueKey("response");

    test('Functional Test: Reversing the string', () async {
      await driver.clearTimeline();


      //1) TEXTFIELD: Fullfill field + Pause to display
      await driver
          .tap(_textField)
          .then((value) => Future.delayed(Duration(seconds: 2)))
          .then((value) => driver.enterText("Hello222"))
          .then((value) => Future.delayed(Duration(seconds: 2)));


      //2) _RESULTLABEL: Should be 'absent'(not displayed) in the screen
      await driver.waitForAbsent(_resultLabel);


      //3) BUTTON: Tap + _resultLable is 'Displayed' in the screen
      await driver
          .tap(_button)
          .then((value) => Future.delayed(Duration(seconds: 2)))
          .then((value) => driver.waitFor(_resultLabel));


      //4) ENDING CALLS: wait till "NO MORE" calls
      await driver.waitUntilNoTransientCallbacks();

      assert(_resultLabel != null);
    });
  });
}