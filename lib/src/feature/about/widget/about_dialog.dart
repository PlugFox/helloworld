import 'package:flutter/material.dart';

/// {@template about_dialog}
/// AboutDialog widget
/// {@endtemplate}
class AboutApplicationDialog extends StatelessWidget {
  /// {@macro about_dialog}
  const AboutApplicationDialog({super.key});

  static void show(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => const AboutApplicationDialog(),
      ).ignore();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Flutter Demo'),
        icon: const FlutterLogo(size: 64),
        insetPadding: const EdgeInsets.all(16),
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(
              '© 2021 Flutter Demo',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
}
