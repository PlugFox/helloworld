import 'package:flutter_test/flutter_test.dart';

Future<Finder> asyncFinder({
  required WidgetTester tester,
  required Finder Function() finder,
  Duration limit = const Duration(milliseconds: 15000),
}) async {
  final stopwatch = Stopwatch()..start();
  try {
    var result = finder();
    while (stopwatch.elapsed <= limit) {
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      result = finder();
      if (result.evaluate().isNotEmpty) return result;
    }
    return result;
  } on Object {
    rethrow;
  } finally {
    stopwatch.stop();
  }
}
