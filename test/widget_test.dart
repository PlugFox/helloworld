import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/src/common/widget/app.dart';
import 'package:helloworld/src/feature/about/widget/about_dialog.dart';

void main() => group('Widget_tests', () {
      testWidgets('Counter_increments_smoke_test', (tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(const App());

        // Verify that our counter starts at 0.
        expect(find.text('0'), findsOneWidget);
        expect(find.text('1'), findsNothing);

        // Tap the '+' icon and trigger a frame.
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify that our counter has incremented.
        expect(find.text('0'), findsNothing);
        expect(find.text('1'), findsOneWidget);
      });

      testWidgets('About_application_dialog', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: AboutApplicationDialog(),
              ),
            ),
          ),
        );
        expect(find.byType(AboutApplicationDialog), findsOneWidget);
        expect(find.textContaining('Version'), findsOneWidget);
      });
    });
