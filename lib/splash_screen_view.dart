import 'dart:developer' as log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/scale_animated_text.dart';
import 'package:tbib_splash_screen/typer_animated_text.dart';

import 'colorize_animated_text.dart';

class SplashScreenView extends StatefulWidget {
  final Widget navigateRoute;
  //new
  final bool? navigateWhere;
  final String? imageSrc;
  final Duration duration;
  final TextStyle? textStyle;
  final double logoSize;
  Duration speed;
  final PageRouteTransition? pageRouteTransition;
  final List<Color>? colors;
  final TextType? textType;
  final Color? backgroundColor;
  final String? text;

  SplashScreenView(
      {Key? key,
      required this.navigateRoute,
      this.imageSrc,
      this.duration = const Duration(milliseconds: 3000),
      this.logoSize = 150,
      this.textStyle,
      this.speed = const Duration(milliseconds: 1000),
      this.pageRouteTransition,
      this.colors,
      this.textType,
      this.backgroundColor,
      this.text,
      this.navigateWhere})
      : assert(navigateWhere != null),
        super(key: key);
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  final double? _defaultTextFontSize = 20;

  bool isNetworkImage = false;
  @override
  void initState() {
    super.initState();
    if (widget.textType == TextType.TyperAnimatedText) {
      widget.speed = Duration(milliseconds: widget.speed.inMilliseconds ~/ 10);
    }
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

    log.log("widget.isNetworkImage $isNetworkImage");

    if (widget.textType == TextType.TyperAnimatedText) {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 100));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController!, curve: Curves.easeInCirc));
      _animationController!.forward();
    } else {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController!, curve: Curves.easeInCirc));
      _animationController!.forward();
    }

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
    _animationController!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (widget.imageSrc != null && widget.imageSrc!.isNotEmpty)
                  ? (isNetworkImage)
                      ? Image.network(
                          widget.imageSrc!,
                          height: widget.logoSize,
                        )
                      : Image.asset(
                          widget.imageSrc!,
                          height: widget.logoSize,
                        )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                child: getTextWidget(),
              ),
              const SizedBox(
                height: 50,
              ),
              awaitLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (widget.text != null) {
      //log("Not Blank");
      switch (widget.textType) {
        case TextType.ColorizeAnimationText:
          return ColorizeAnimatedText(
            text: widget.text,
            speed: widget.speed,
            textStyle: (widget.textStyle != null)
                ? widget.textStyle
                : TextStyle(fontSize: _defaultTextFontSize),
            colors: (widget.colors != null)
                ? widget.colors!
                : [
                    Colors.blue,
                    Colors.black,
                    Colors.blue,
                    Colors.black,
                  ],
          );
        case TextType.NormalText:
          return Text(
            widget.text!,
            style: (widget.textStyle != null)
                ? widget.textStyle
                : TextStyle(fontSize: _defaultTextFontSize),
          );
        case TextType.TyperAnimatedText:
          return TyperAnimatedText(
            text: widget.text,
            speed: widget.speed,
            textStyle: (widget.textStyle != null)
                ? widget.textStyle
                : TextStyle(fontSize: _defaultTextFontSize),
          );
        case TextType.ScaleAnimatedText:
          return ScaleAnimatedText(
            text: widget.text,
            textStyle: (widget.textStyle != null)
                ? widget.textStyle
                : TextStyle(fontSize: _defaultTextFontSize),
          );
        default:
          return Text(
            widget.text!,
            style: (widget.textStyle != null)
                ? widget.textStyle
                : TextStyle(fontSize: _defaultTextFontSize),
          );
      }
    } else {
      //log("Blank");
      return const SizedBox(
        width: 1,
      );
    }
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

enum TextType {
  ColorizeAnimationText,
  TyperAnimatedText,
  ScaleAnimatedText,
  NormalText,
}

enum PageRouteTransition {
  Normal,
  CupertinoPageRoute,
  SlideTransition,
}
