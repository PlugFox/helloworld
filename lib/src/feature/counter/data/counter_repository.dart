abstract class ICounterRepository {
  Future<int> increment(int value);
  Future<int> decrement(int value);
  int incrementSync(int value);
  int decrementSync(int value);
}

class CounterRepositoryImpl implements ICounterRepository {
  CounterRepositoryImpl();

  @override
  Future<int> increment(int value) => Future<int>.delayed(const Duration(seconds: 2), () => value + 1);

  @override
  Future<int> decrement(int value) => Future<int>.delayed(const Duration(seconds: 2), () => value - 1);

  @override
  int decrementSync(int value) => throw UnimplementedError();

  @override
  int incrementSync(int value) => throw UnimplementedError();
}

abstract class ICounterNetworkDataProvider {
  Future<int> increment(int value);
  Future<int> decrement(int value);
}
