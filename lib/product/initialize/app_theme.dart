import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme(this.context);
  final BuildContext context;

  ThemeData get theme => ThemeData.light().copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(8),
            ),
            textStyle: MaterialStateProperty.all<TextStyle?>(
                Theme.of(context).textTheme.headlineSmall),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      );
}
