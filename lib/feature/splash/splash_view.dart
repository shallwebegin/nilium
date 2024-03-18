// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nilium/feature/home/home_view.dart';
import 'package:nilium/feature/splash/splash_provider.dart';
import 'package:nilium/product/constants/color_constants.dart';
import 'package:nilium/product/constants/enums/image_constants.dart';
import 'package:nilium/product/constants/string_constants.dart';
import 'package:nilium/product/widget/text/wavy_text.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashViewListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).checkApplicationVersion('');
  }

  @override
  Widget build(BuildContext context) {
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.purplePrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            Padding(
              padding: const EdgeInsets.all(8),
              child: const WavyText(title: StringConstants.appName),
            )
          ],
        ),
      ),
    );
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
      StateNotifierProvider<SplashProvider, SplashState> provider) {
    ref.listen(provider, (previous, next) {
      if (next.isRequiredForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }

      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else {
          //false
        }
      }
    });
  }
}
