import 'dart:io';

import 'package:nilium/product/utility/exception/custom_exception.dart';

enum PlatformEnum {
  android,
  ios;

  static String get versionName {
    if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }
    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    }

    throw PlatformCustomException('Platform unused please check!');
  }
}
