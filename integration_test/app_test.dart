import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:non/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "check the textfields if they are empty and do not naigate to the display screen afterwards",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TypingPage), findsOneWidget);
    expect(find.byType(DisplayPage), findsNothing);
  });

  testWidgets(
      "check if the text field contains a value and move to a display page",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final text = "a text";
    await tester.enterText(
        find.byKey(
          Key("your-text-field"),
        ),
        text);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(DisplayPage), findsOneWidget);
    expect(find.byType(TypingPage), findsNothing);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(TypingPage), findsOneWidget);
    expect(find.byType(DisplayPage), findsNothing);
  });
}
