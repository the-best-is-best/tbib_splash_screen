# TBIB Splash Screen

this package work with
[Animated Text Kit](https://pub.dev/packages/animated_text_kit)
to animated text

see all animated text in Animated Text Kit

Alert removed create native splash screen

## you can use navigate where app is loaded

```dart
       SplashScreenView(
               navigateWhere: isLoaded,
               navigateRoute: const HomeScreen(),
               text: WavyAnimatedText(
                 "Splash Screen",
                 textStyle: const TextStyle(
                   color: Colors.red,
                   fontSize: 32.0,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               imageSrc: "assets/logo_light.png",
             ),
```

## you can use use [lottie package](https://pub.dev/packages/lottie)

```dart
        SplashScreenView(
            navigateWhere: isLoaded,
            navigateRoute: const HomeScreen(),
            text: WavyAnimatedText(
                "Splash Screen",
                textStyle: const TextStyle(
                color: Colors.red,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                ),
            ),
            imageSrc: "assets/logo_light_lottie.json",
            //  displayLoading: false,
      );
```
