// ignore_for_file: unnecessary_lambdas, only_throw_errors

import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/src/feature/counter/data/counter_repository.dart';

void main() => group('Unit_tests', () {
      late final ICounterRepository repository;

      setUpAll(() async {
        repository = CounterRepositoryImpl();
      });

      tearDownAll(() async {});

      test('Math', () {
        expect(1 + 2, equals(3));
      });

      test('CounterRepository', () {
        expect(repository, isA<ICounterRepository>());
        expect(() => CounterRepositoryImpl(), returnsNormally);
      });

      test('Unimplemented_methods', () {
        expect(() => throw Exception('My exception'), throwsException);
        expect(() => repository.incrementSync(1), throwsUnimplementedError);
        expect(() => repository.decrementSync(2), throwsA(isA<UnimplementedError>()));
      });

      test('Increment', () async {
        expect(repository.increment(0), completion(1));
        expect(repository.increment(1), completion(2));
      });

      test('Decrement', () {
        expect(repository.decrement(2), completion(1));
        expect(repository.decrement(1), completion(0));
      });

      test(
        'Counter_stream',
        () {
          final sample = <int>[1, 2, 3];
          expectLater(
            Stream<int>.fromIterable(sample)
                .asyncMap<int>(repository.increment)
                .asyncMap<int>((event) => repository.decrement(event)),
            emitsInOrder(sample),
          );
        },
        timeout: const Timeout(Duration(seconds: 15)),
      );
    });
