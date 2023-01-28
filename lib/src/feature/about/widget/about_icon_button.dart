import 'package:flutter/material.dart';

import 'about_dialog.dart';

/// {@template about_icon_button}
/// AboutIconButton widget
/// {@endtemplate}
class AboutIconButton extends StatelessWidget {
  /// {@macro about_icon_button}
  const AboutIconButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => AboutApplicationDialog.show(context),
        icon: const Icon(Icons.info),
      );
}
