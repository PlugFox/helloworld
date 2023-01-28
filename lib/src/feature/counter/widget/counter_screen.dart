import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/controller/listenable_selector.dart';
import '../../about/widget/about_icon_button.dart';
import 'counter_progress_barrier.dart';
import 'counter_scope.dart';

/// {@template counter_screen}
/// CounterScreen widget
/// {@endtemplate}
class CounterScreen extends StatelessWidget {
  /// {@macro counter_screen}
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
          actions: <Widget>[
            IconButton(
              key: const ValueKey<String>('counter_screen_license_button'),
              onPressed: () => showLicensePage(context: context),
              icon: const Icon(Icons.abc),
            ),
            const AboutIconButton(),
          ],
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: CounterScope.of(context, listen: false).select(
            (state) => state.isProcessing,
            (prev, next) => prev != next,
          ),
          builder: (context, isProcessing, child) => CounterProgressBarrier(
            inProgress: isProcessing,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const _Count(),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          _DecrementButton(),
                          SizedBox(width: 24),
                          _IncrementButton(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _DecrementButton extends StatelessWidget {
  const _DecrementButton();

  @override
  Widget build(BuildContext context) {
    final controller = CounterScope.maybeOf(context);
    final inProgress = controller?.isProcessing ?? false;
    final state = controller?.state ?? 0;
    final enabled = !inProgress && state > 0;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: enabled ? 1 : .5,
      child: FloatingActionButton(
        heroTag: 'decrement',
        tooltip: 'Decrement counter',
        onPressed: enabled ? () => controller?.decrement() : null,
        backgroundColor: enabled ? Colors.red : Colors.grey,
        child: const Icon(Icons.remove),
      ),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  const _IncrementButton();

  @override
  Widget build(BuildContext context) {
    final controller = CounterScope.maybeOf(context);
    final inProgress = controller?.isProcessing ?? false;
    final state = controller?.state ?? 0;
    final enabled = !inProgress && state < 99;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: enabled ? 1 : .5,
      child: FloatingActionButton(
        heroTag: 'increment',
        tooltip: 'Increment counter',
        onPressed: enabled ? () => controller?.increment() : null,
        backgroundColor: enabled ? Colors.blue : Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count();

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: ValueListenableBuilder<int>(
          valueListenable: CounterScope.of(context, listen: false).select<int>(
            (controller) => controller.state,
            (prev, next) => prev != next,
          ),
          builder: (context, state, _) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(animation),
                alignment: Alignment.bottomCenter,
                child: child,
              ),
            ),
            child: Text(
              key: ValueKey<int>(state),
              state.toString(),
              style: GoogleFonts.coiny(
                fontSize: 86,
                fontWeight: FontWeight.bold,
                height: 1,
                color: Colors.white,
                shadows: <Shadow>[
                  const BoxShadow(
                    color: Colors.white24,
                    offset: Offset(-2, -2),
                    blurRadius: 8,
                  ),
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 8,
                  ),
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 6,
                  ),
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
