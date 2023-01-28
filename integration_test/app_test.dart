import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/src/common/initialization/initialization.dart';
import 'package:helloworld/src/common/widget/app.dart';
import 'package:helloworld/src/feature/about/widget/about_dialog.dart';
import 'package:helloworld/src/feature/counter/controller/counter_controller.dart';
import 'package:helloworld/src/feature/counter/widget/counter_scope.dart';
import 'package:helloworld/src/feature/counter/widget/counter_screen.dart';
import 'package:integration_test/integration_test.dart';

import 'src/util/async_finder.dart';

void main() {
  // ignore: unused_local_variable
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end_tests', () {
    setUp(() async {
      await $initializeApp();
    });

    tearDown(() async {
      await $disposeApp();
    });

    testWidgets('Counter_test', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());
      await asyncFinder(tester: tester, finder: () => find.byType(App));

      // Check initial state.
      expect(find.byType(App), findsOneWidget);
      expect(find.byType(CounterScope), findsOneWidget);
      expect(find.byType(CounterScreen), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsAtLeastNWidgets(2));
      expect(find.text('0'), findsOneWidget);

      // Check controller
      final controller = CounterScope.maybeOf(tester.firstElement(find.byType(CounterScreen)), listen: false);
      expect(controller, isA<ICounterController>());
      expect(controller?.isProcessing, isFalse);
      expect(controller?.state, same(0));

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);

      // Tap the '+' icon one more time and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await asyncFinder(tester: tester, finder: () => find.text('2'));
      expect(find.text('1'), findsNothing);
      expect(find.text('2'), findsOneWidget);

      // Tap the '-' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.remove));
      await asyncFinder(tester: tester, finder: () => find.text('1'));
      expect(find.text('2'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('License_test', (tester) async {
      await tester.pumpWidget(const App());
      await asyncFinder(tester: tester, finder: () => find.byType(App));
      expect(find.byType(App), findsOneWidget);
      final licenseFinder = find.byKey(const ValueKey<String>('counter_screen_license_button'));
      expect(licenseFinder, findsOneWidget);
      await tester.tap(licenseFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(LicensePage), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      await tester.tap(find.byType(BackButton));
    });

    testWidgets('About_test', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AboutApplicationDialog(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AboutApplicationDialog), findsOneWidget);
      expect(find.textContaining('Version'), findsOneWidget);
    });
  });
}
