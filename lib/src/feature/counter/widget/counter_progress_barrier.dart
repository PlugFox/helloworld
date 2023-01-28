import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../common/widget/radial_progress_indicator.dart';

/// {@template counter_progress_barrier}
/// CounterProgressBarrier widget
/// {@endtemplate}
class CounterProgressBarrier extends StatelessWidget {
  /// {@macro counter_progress_barrier}
  const CounterProgressBarrier({
    required this.inProgress,
    required this.child,
    super.key,
  });

  final bool inProgress;
  final Widget child;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: inProgress,
        child: Stack(
          children: <Widget>[
            // Content
            Positioned.fill(child: child),
            // Barrier
            Positioned.fill(
              child: RepaintBoundary(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: inProgress
                      ? RepaintBoundary(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: ColoredBox(
                                color: Colors.grey.withOpacity(.15),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            // Progress indicator
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 650),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: CurvedAnimation(parent: animation, curve: const Interval(0, .5)),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ),
                child: inProgress ? const _ProgressIndicator() : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      );
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 128,
          child: RepaintBoundary(
            child: RadialProgressIndicator(
              size: 128,
            ),
          ),
        ),
      );
}
