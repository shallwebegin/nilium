import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WavyBoldText extends StatelessWidget {
  const WavyBoldText({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          title,
          textStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 1000),
        ),
      ],
      totalRepeatCount: 4,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
