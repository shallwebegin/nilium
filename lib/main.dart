import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nilium/feature/auth/authentication_view.dart';
import 'package:nilium/feature/home/home_view.dart';

import 'package:nilium/product/constants/string_constants.dart';
import 'package:nilium/product/initialize/app_start_init.dart';
import 'package:nilium/product/initialize/app_theme.dart';

Future<void> main() async {
  await ApplicationStart.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      theme: AppTheme(context).theme,
      home: HomeView(),
    );
  }
}
