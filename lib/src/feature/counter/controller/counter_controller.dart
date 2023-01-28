import '../../../common/controller/state_controller.dart';
import '../data/counter_repository.dart';

abstract class ICounterController extends IStateController<int> {
  Future<void> increment();
  Future<void> decrement();
}

abstract class _CounterControllerBase extends StateController<int> implements ICounterController {
  _CounterControllerBase({required ICounterRepository repository, required int initialState})
      : _repository = repository,
        super(initialState);

  final ICounterRepository _repository;
}

class CounterController = _CounterControllerBase with _IncrementMixin, _DecrementMixin;

mixin _IncrementMixin on _CounterControllerBase {
  @override
  Future<void> increment() => handle(() async {
        final incremented = await _repository.increment(state);
        setState(incremented.clamp(0, 99));
      });
}

mixin _DecrementMixin on _CounterControllerBase {
  @override
  Future<void> decrement() => handle(() async {
        final decremented = await _repository.decrement(state);
        setState(decremented.clamp(0, 99));
      });
}
