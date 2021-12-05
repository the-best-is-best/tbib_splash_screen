import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

/// Abstract base class for text animations.
abstract class AnimatedText {
  /// Text for [Text] widget.
  final String text;

  /// [TextAlign] property for [Text] widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// [TextStyle] property for [Text] widget.
  final TextStyle? textStyle;

  /// The Duration for the Animation Controller.
  ///
  /// This will set the total duration for the animated widget.
  /// For example, if you want the text animation to take 3 seconds,
  /// then you have to set [duration] to 3 seconds.
  final Duration duration;

  /// Same as [text] but as [Characters].
  ///
  /// Need to use character length, not String length, to propertly support
  /// Unicode and Emojis.
  final Characters textCharacters;
  final bool isSplashScreen;

  AnimatedText({
    required this.text,
    this.textAlign = TextAlign.start,
    this.textStyle,
    required this.duration,
    this.isSplashScreen = false,
  }) : textCharacters = text.characters;

  /// Return the remaining Duration for the Animation (when applicable).
  Duration? get remaining => null;

  /// Initialize the Animation.
  void initAnimation(AnimationController controller);

  /// Utility method to create a styled [Text] widget using the [textAlign] and
  /// [textStyle], but you can specify the [data].
  Widget textWidget(String data) => Text(
        data,
        textAlign: textAlign,
        style: textStyle,
      );

  /// Widget showing the complete text (when animation is complete or paused).
  /// By default, it shows a Text widget, but this may be overridden.
  Widget completeText(BuildContext context) => textWidget(text);

  /// Widget showing animated text, based on animation value(s).
  Widget animatedBuilder(BuildContext context, Widget? child);
}
