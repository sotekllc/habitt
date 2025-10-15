# habitt

A habit tracking capstone project in Flutter.


## Features

- Login page
- Signup page
- Homepage
- Detailed screen
- Settings menu
- Settings screen
- Integrate Persistent Data
- Integrate External API
- Notifications


## Architecture

Rough DDD follows an MVVM (Model-View-ViewModel) pattern using the [provider package](https://pub.dev/packages/provider) for state management. Separates the logic into three layers and uses repositories for interacting with domain objects.


## Getting Started

This project is a mobile app built for iOS and Android platforms. It's a very basic Habit tracking app that includes a weekly report of habits progress. It uses local storage for persistence (which can be expanded upon using the repository contracts) of items and settings, which reload when the app is reloaded and are deleted when the app is deleted.

### Running on a simulator

Install the following dependencies using the Flutter documentation guide on getting started (you may choose either [android](https://docs.flutter.dev/platform-integration/android/setup) or [iOS](https://docs.flutter.dev/platform-integration/ios/setup) for setup and respectively install either Android Studio or XCode or both):

* [Flutter Install](https://docs.flutter.dev/install)

Then proceed with targeting either or both platforms for setup of the studio/xcode and simulators.

Finally, clone this project to a new project folder, open one of the platform simulator devices, and run the following command from the command line:

```
make run
```


## Development

* Personas and needs: Identify different user types and their main needs.
* User stories: Write clear, concise user stories combining who, what, and why.
* Prioritize: Focus on stories that provide the most immediate value to the user.
* Validation and refinement: Gather feedback to ensure stories accurately reflect user needs.
