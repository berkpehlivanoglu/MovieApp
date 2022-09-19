# MovieApp

A movie app with splash, home and detail screens.

# Demo

![MovieAppDemo_AdobeExpress (1)](https://user-images.githubusercontent.com/81172741/190165558-8dcf5371-64b2-44e0-9592-23f7ceb3ce98.gif)


# Requirements
- Xcode 11+
- iOS 13.0+
- Swift 5.0
- [CocoaPods](https://cocoapods.org/) to manage 3rd party dependencies

# Installation

1. Download or clone the project.
2. Navigate to the project directory and install third-party libraries.

```bash
  pod install
```
3. Open MovieApp.xcworkspace in Xcode.
4. Run the project on simulator or your real iPhone device.

# Technical Considerations

- Firebase remote config is used for the SplashView screen to show text from the console.
- Firebase Analytics is used for the MovieDetail screen to log the movie data.
- MVC architecture is used to design the app.
- Used 3rd party depencencies.
- This is a demo project and not intended to be used at scale or published on the AppStore.
- [SwiftLint](https://github.com/realm/SwiftLint) is used to keep the code consistent and clean.
