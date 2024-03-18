import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nilium/feature/auth/authentication_provider.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
          actions: [
            firebase.AuthStateChangeAction<firebase.SignedIn>((context, state) {
              if (state.user != null) {
                print('okay');
              }
            }),
          ],
          child: firebase.LoginView(
            action: firebase.AuthAction.signIn,
            providers:
                firebase.FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
          )),
    );
  }
}
