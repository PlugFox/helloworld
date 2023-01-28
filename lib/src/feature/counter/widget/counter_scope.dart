import 'package:flutter/widgets.dart';

import '../controller/counter_controller.dart';
import '../data/counter_repository.dart';

/// {@template counter_scope}
/// CounterScope widget
/// {@endtemplate}
class CounterScope extends StatefulWidget {
  /// {@macro counter_scope}
  const CounterScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `CounterScope.maybeOf(context)`
  static ICounterController? maybeOf(BuildContext context, {bool listen = true}) =>
      _InheritedCounterScope.maybeOf(context, listen: listen);

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `CounterScope.of(context)`
  static ICounterController of(BuildContext context, {bool listen = true}) =>
      _InheritedCounterScope.of(context, listen: listen);

  @override
  State<CounterScope> createState() => _CounterScopeState();
}

/// State for widget CounterScope
class _CounterScopeState extends State<CounterScope> {
  late final ICounterController _counterController;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _counterController = CounterController(
      repository: CounterRepositoryImpl(),
      initialState: 0,
    );
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => _InheritedCounterScope(
        counterController: _counterController,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree
class _InheritedCounterScope extends InheritedNotifier {
  const _InheritedCounterScope({
    required this.counterController,
    required super.child,
  }) : super(notifier: counterController);

  final ICounterController counterController;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `CounterScope.maybeOf(context)`
  static ICounterController? maybeOf(BuildContext context, {bool listen = true}) => (listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedCounterScope>()
          : context.getElementForInheritedWidgetOfExactType<_InheritedCounterScope>()?.widget
              as _InheritedCounterScope?)
      ?.counterController;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedCounterScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `CounterScope.of(context)`
  static ICounterController of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();
}
