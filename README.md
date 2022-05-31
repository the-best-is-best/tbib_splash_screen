# TBIB Splash Screen

this package work with
[Animated Text Kit](https://pub.dev/packages/animated_text_kit)
to animated text 

see all animated text in Animated Text Kit

## but add new animations for fade anim , route and scale to disable fade out text 

* FadeAnimatedSplashScreenText - RotateAnimatedSplashScreenText - ScaleAnimatedSplashScreenText

## v 0.0.5
  Support gradient color in backgrond if you want 
  

## v 0.0.2

 Support lottie file.

# Description

They say, first impression is the last! Yep, truly for any amazingly crafted application, it's easier to start impressing your audience with a good start - the splash screen!

Every time a flutter application is started, it takes some time to load the Dart isolate (which runs the code). This means user will see a blank white screen till Flutter renders the first frame of the application.

Use this package automatically generates android, iOS, and Web native code for customizing this native splash screen background color and splash image. Supports dark mode, full screen, and platform-specific options.

The native splash screen is displayed till Flutter renders the first frame of the application. After that you have to load your real splash screen.

This package also contains a collection of Splash Screen example for your application to display logo and different style of text.

<table>
<tr><th>Before Splash screen</th><th>After Splash screen</th></tr>
<tr><td><img src="https://raw.githubusercontent.com/the-best-is-best/tbib_splash_screen/master/src/Before_Splash.gif" height = "400px"></td><td><img src="https://raw.githubusercontent.com/the-best-is-best/tbib_splash_screen/master/src/After_Splash.gif" align = "right" height = "400px"></td></tr>
</table>

# Setting the native splash screen
```yaml
tbib_splash_screen:
  # Use color to set the background of your splash screen to a solid color.
  # Use background_image to set the background of your splash screen to a png image.
  # This is useful for gradients. The image will be stretch to the  size of the app.
  # Only one parameter can be used, color and background_image cannot both be set.

  color: "#ffffff"
  #background_image: "assets/splashscreen_image.png"

  # Optional parameters are listed below.
  #image: assets/splashscreen_image.png

  #color_dark: "#042a49"
  #background_image_dark: "assets/dark-background.png"
  #image_dark: assets/splash-invert.png

  #android: false
  #ios: false
  #web: false

  #android_gravity: center
  #ios_content_mode: center
  #web_image_mode: center

  #fullscreen: true

  #info_plist_files:
  #  - 'ios/Runner/Info-Debug.plist'
  #  - 'ios/Runner/Info-Release.plist'
```

# but to create native splash screen 

flutter pub run tbib_splash_screen:create

# but to remove native splash screen 

flutter pub run tbib_splash_screen:remove

# back to splash screen after open app

```dart
  SplashScreenView(
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
      // paddingText
      // paddingLoading
    );
 ```

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


## you can use use  [lottie package](https://pub.dev/packages/lottie)


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