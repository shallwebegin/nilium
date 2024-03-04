import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:nilium/feature/home/home_view.dart';
import 'package:nilium/feature/splash/splash_provider.dart';
import 'package:nilium/product/constants/color_constants.dart';
import 'package:nilium/product/constants/string_constants.dart';
import 'package:nilium/product/enums/image_constants.dart';
import 'package:nilium/product/widget/text/wavy_text.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashWievListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).checkApplicationVersion(''.version);
  }

  @override
  Widget build(BuildContext context) {
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.purpleDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.splashLogo.toImage,
            Padding(
              padding: context.paddingHigh,
              child: WavyBoldText(title: StringConstants.appName),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _SplashWievListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
      StateNotifierProvider<SplashProvider, SplashState> provider) {
    ref.listen(
      provider,
      (previous, next) {
        if (next.isRequiredForceUpdate ?? false) {
          showAboutDialog(context: context);
          return;
        }
        if (next.isRedirectHome != null) {
          if (next.isRedirectHome!) {
            context.navigateToPage(const HomeView());
          } else {}
        }
      },
    );
  }
}
