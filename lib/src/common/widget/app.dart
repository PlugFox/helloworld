import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../feature/counter/widget/counter_scope.dart';
import '../../feature/counter/widget/counter_screen.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Hello world',
        restorationScopeId: 'material_app',
        debugShowCheckedModeBanner: false,
        /*
        localizationsDelegates: const <LocalizationsDelegate<Object?>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
        */
        theme: ui.window.platformBrightness == Brightness.dark ? ThemeData.dark() : ThemeData.light(),
        home: const CounterScreen(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Banner(
            message: 'PREVIEW',
            location: BannerLocation.topEnd,
            child: CounterScope(child: child ?? const SizedBox.shrink()),
          ),
        ),
      );
}
