import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// Animated Text that rotates a [Text] in and then out.
///
/// ![Rotate example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/rotate.gif)
class RotateAnimatedSplashScreenText extends AnimatedText {
  /// Transition height.
  ///
  /// By default it is set to [TextStyle.fontSize] * 10 / 3.
  final double? transitionHeight;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [Alignment.center]
  final AlignmentGeometry alignment;

  /// Specifies the [TextDirection] for resolving alignment.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  /// Controls whether the text:
  /// * rotates in _and_ out (true), or
  /// * just rotates _in_ (false).
  ///
  /// Note that you may want to adjust the [duration] when mixing
  /// [RotateAnimatedText] instances with mixed [rotateOut] values.
  ///
  /// By default, it is set to true.

  RotateAnimatedSplashScreenText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.transitionHeight,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn;
  late Animation<Alignment> _slideIn;

  @override
  void initAnimation(AnimationController controller) {
    final direction = textDirection;

    const double inIntervalEnd = 1.0;

    _slideIn = AlignmentTween(
      begin: Alignment.topCenter.add(alignment).resolve(direction),
      end: Alignment.center.add(alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, inIntervalEnd, curve: Curves.linear),
      ),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, inIntervalEnd, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final fontSize =
        textStyle?.fontSize ?? DefaultTextStyle.of(context).style.fontSize;

    return SizedBox(
      height: transitionHeight ?? (fontSize! * 10 / 3),
      child: AlignTransition(
        alignment: _slideIn,
        child: Opacity(
          opacity: _fadeIn.value,
          child: textWidget(text),
        ),
      ),
    );
  }
}
