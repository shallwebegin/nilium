import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nilium/feature/auth/authentication_provider.dart';
import 'package:nilium/product/constants/string_constants.dart';

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
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
          actions: [
            firebase.AuthStateChangeAction<firebase.SignedIn>((context, state) {
              if (state.user != null) {
                checkUser(state.user);
              }
            }),
          ],
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConstants.welcomeNiliumApp,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: firebase.LoginView(
                      action: firebase.AuthAction.signIn,
                      showTitle: false,
                      providers: firebase.FirebaseUIAuth.providersFor(
                          FirebaseAuth.instance.app),
                    ),
                  ),
                ),
                if (ref.watch(authProvider).isRedirect)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      StringConstants.continiueToApp,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
