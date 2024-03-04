import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nilium/firebase_options.dart';

@immutable
class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.deviceInit();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
