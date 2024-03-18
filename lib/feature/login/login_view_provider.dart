import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider extends StateNotifier<int> {
  LoginProvider() : super(0);

  void increment() {
    state++;
  }
}

final loginProvider = StateNotifierProvider<LoginProvider, int>((ref) {
  return LoginProvider();
});
