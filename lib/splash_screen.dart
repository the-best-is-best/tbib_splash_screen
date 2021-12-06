import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/animated_splash_text.dart';

class SplashScreenView extends StatefulWidget {
  final Widget navigateRoute;
  final bool? navigateWhere;
  final String? imageSrc;
  final Duration duration;
  final double logoSize;
  Duration speed;
  final PageRouteTransition? pageRouteTransition;
  final EdgeInsets paddingText;
  final AnimatedText? text;
  final Color backgroundColor;
  final EdgeInsets paddingLoading;
  SplashScreenView({
    Key? key,
    required this.navigateRoute,
    required this.navigateWhere,
    required this.imageSrc,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(milliseconds: 3000),
    this.logoSize = 150,
    this.speed = const Duration(milliseconds: 1000),
    this.pageRouteTransition,
    this.paddingText = const EdgeInsets.only(right: 10, left: 10, top: 20),
    this.text,
    this.paddingLoading = const EdgeInsets.only(bottom: 100),
  }) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  //final double? _defaultTextFontSize = 20;
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool isNetworkImage = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));

    _animationController.forward();
    if (widget.imageSrc != null && widget.imageSrc!.isNotEmpty) {
      if (widget.imageSrc!.startsWith("http://") ||
          widget.imageSrc!.startsWith("https://")) {
        isNetworkImage = true;
      } else {
        isNetworkImage = false;
      }
    } else {
      isNetworkImage = false;
    }

    log("widget.isNetworkImage $isNetworkImage");

    if (widget.navigateWhere == null) {
      Future.delayed(
              Duration(milliseconds: widget.duration.inMilliseconds + 2000))
          .then((value) {
        if (widget.pageRouteTransition ==
            PageRouteTransition.CupertinoPageRoute) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) => widget.navigateRoute));
        } else if (widget.pageRouteTransition ==
            PageRouteTransition.SlideTransition) {
          Navigator.of(context).pushReplacement(_tweenAnimationPageRoute());
        } else {
          Navigator.of(context).pushReplacement(_normalPageRoute());
        }
      });
    } else {
      Future.delayed(
              Duration(milliseconds: widget.duration.inMilliseconds + 2000))
          .then((value) {
        waitUntilWhereEqualTrue();
      });
    }
  }

  bool awaitLoading = false;
  void waitUntilWhereEqualTrue() async {
    while (widget.navigateWhere == false) {
      await Future.delayed(const Duration(seconds: 1));
      if (!awaitLoading) {
        setState(() {
          awaitLoading = true;
        });
      }
      waitUntilWhereEqualTrue();
    }
    if (widget.pageRouteTransition == PageRouteTransition.CupertinoPageRoute) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (BuildContext context) => widget.navigateRoute));
    } else if (widget.pageRouteTransition ==
        PageRouteTransition.SlideTransition) {
      Navigator.of(context).pushReplacement(_tweenAnimationPageRoute());
    } else {
      Navigator.of(context).pushReplacement(_normalPageRoute());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: <Widget>[
              (widget.imageSrc != null && widget.imageSrc!.isNotEmpty)
                  ? (isNetworkImage)
                      ? Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            widget.imageSrc!,
                            height: widget.logoSize,
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            widget.imageSrc!,
                            height: widget.logoSize,
                          ),
                        )
                  : const SizedBox(),
              widget.text != null
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: widget.logoSize + 40),
                        child: Padding(
                          padding: widget.paddingText,
                          child: SizedBox(height: 100, child: getTextWidget()),
                        ),
                      ),
                    )
                  : const SizedBox(),
              awaitLoading == true
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: widget.paddingLoading,
                        child: const CircularProgressIndicator(),
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    return AnimatedSplashTextKit(
      animatedTexts: [widget.text!],
    );
  }

  Route _tweenAnimationPageRoute() {
    /// Tween Animation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          widget.navigateRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Route _normalPageRoute() {
    /// Normal Animation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          widget.navigateRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

enum PageRouteTransition {
  Normal,
  CupertinoPageRoute,
  SlideTransition,
}
