import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// Animated Text that displays a [Text] element, fading it in and then out.
///
/// ![Fade example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/fade.gif)
class FadeAnimatedSplashScreenText extends AnimatedText {
  /// Marks ending of fade-in interval, default value = 0.5
  final double fadeInEnd;

  /// Marks the beginning of fade-out interval, default value = 0.8

  FadeAnimatedSplashScreenText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.fadeInEnd = 0.5,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn;
  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, fadeInEnd, curve: Curves.linear),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => const SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : 1,
      child: textWidget(text),
    );
  }
}
