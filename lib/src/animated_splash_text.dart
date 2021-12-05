import 'package:flutter/material.dart';

import 'class/class_animated_text.dart';

/// Base class for Animated Text widgets.
class AnimatedSplashTextKit extends StatefulWidget {
  /// List of [AnimatedText] to display subsequently in the animation.
  final List<AnimatedText> animatedTexts;
  AnimatedSplashTextKit({
    Key? key,
    required this.animatedTexts,
  })  : assert(animatedTexts.isNotEmpty),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  _AnimatedTextKitState createState() => _AnimatedTextKitState();
}

class _AnimatedTextKitState extends State<AnimatedSplashTextKit>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late AnimatedText _currentAnimatedText;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completeText = _currentAnimatedText.completeText(context);
    return SizedBox(
      child: AnimatedBuilder(
        animation: _controller,
        builder: _currentAnimatedText.animatedBuilder,
        child: completeText,
      ),
    );
  }

  void _initAnimation() {
    _currentAnimatedText = widget.animatedTexts[0];

    _controller = AnimationController(
      duration: _currentAnimatedText.duration,
      vsync: this,
    );

    _currentAnimatedText.initAnimation(_controller);

    _controller
      ..addStatusListener
      ..forward();
  }
}
