import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// Animated Text that displays a [Text] element, scaling them up and then out.
///
/// ![Scale example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/scale.gif)
class ScaleAnimatedSplashScreenText extends AnimatedText {
  /// Set the scaling factor of the text for the animation.
  ///
  /// By default it is set to [double] value 0.5
  final double scalingFactor;

  ScaleAnimatedSplashScreenText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.scalingFactor = 0.5,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn, _scaleIn;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleIn = Tween<double>(begin: scalingFactor, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => const SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return ScaleTransition(
      scale: _scaleIn,
      child: Opacity(
        opacity: _fadeIn.value,
        child: textWidget(text),
      ),
    );
  }
}
