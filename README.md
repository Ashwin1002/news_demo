# news_demo

News application built in Flutter

## Prerequisites

Ensure the following are installed on your system:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio** or **Xcode** for running app:
  - **Android**: Java/Kotlin setup with an emulator or a connected physical device.
  - **iOS**: Xcode and a valid Apple Developer account (if testing on a physical device).
- **Dart**: Ensure Dart is configured as part of your Flutter setup.

## Getting Started

1. Register for a new api key from [NewsApi](https://newsapi.org/account)
2. Clone the project ```https://github.com/Ashwin1002/news_demo.git```
3. Create a `.env` file in the root of the project folder
4. Assign the below variables:

```
API_BASE_URL = "https://newsapi.org/v2"
API_KEY = <YOUR-API-KEY>
```

5. Run command `flutter pub get` in your terminal in project folder
6. Run command

```
    dart run build_runner build -d
```

for generating `.g, .freezed, .gr, .config` files. 

7. Run the app using `flutter run` command

## Depedencies
| Dependency                | Package                                                                 | Usage                                      |
|---------------------------|-------------------------------------------------------------------------|--------------------------------------------|
| auto_route                | [auto_route](https://pub.dev/packages/auto_route)                       | Declarative routing for Flutter            |
| bloc_concurrency          | [bloc_concurrency](https://pub.dev/packages/bloc_concurrency)           | Controls event concurrency in BLoC         |
| cached_network_image      | [cached_network_image](https://pub.dev/packages/cached_network_image)   | Caching and displaying network images      |
| dio                       | [dio](https://pub.dev/packages/dio)                                     | Powerful HTTP client for Dart              |
| equatable                 | [equatable](https://pub.dev/packages/equatable)                         | Simplifies value comparisons               |
| flutter_bloc              | [flutter_bloc](https://pub.dev/packages/flutter_bloc)                   | BLoC pattern state management              |
| flutter_dotenv            | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)               | Load environment variables                 |
| fpdart                    | [fpdart](https://pub.dev/packages/fpdart)                               | Functional programming tools for Dart      |
| freezed_annotation        | [freezed_annotation](https://pub.dev/packages/freezed_annotation)       | Annotations for the Freezed package        |
| get_it                    | [get_it](https://pub.dev/packages/get_it)                               | Simple service locator for dependency injection |
| google_fonts              | [google_fonts](https://pub.dev/packages/google_fonts)                   | Use Google Fonts in Flutter                |
| injectable                | [injectable](https://pub.dev/packages/injectable)                       | Dependency injection generator             |
| internet_connection_checker| [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) | Check internet connectivity         |
| intl                      | [intl](https://pub.dev/packages/intl)                                   | Updating Date Format    |
| json_annotation           | [json_annotation](https://pub.dev/packages/json_annotation)             | JSON serialization annotations             |
| path                      | [path](https://pub.dev/packages/path)                                   | Joining file paths                      |
| skeletonizer             | [skeletonizer](https://pub.dev/packages/skeletonizer)                   | Skeleton loading animation                 |
| sqflite                   | [sqflite](https://pub.dev/packages/sqflite)                             | SQLite plugin for Flutter(Local Storage)                  |
| stream_transform          | [stream_transform](https://pub.dev/packages/stream_transform)           | Stream transformation utilities            |
| url_launcher              | [url_launcher](https://pub.dev/packages/url_launcher)                   | Launch URLs in browser or apps             |

## About App Arichitecture & Business Logic

This structure follows the **feature-first** and **clean architecture** approach, where each feature contains its own layers: data, domain, and presentation.


### 📂 `data/`
Contains all data-related logic:
- `datasource/`: APIs, local DB sources, or any external data services.
- `model/`: Data models representing the structure of responses or local entities.

### 📂 `domain/`
Contains business logic and abstractions:
- `repository/`: Holds abstract repository classes or concrete implementations like `home_repository.dart` that act as bridges between `data` and `presentation`.

### 📂 `presentation/`
Handles everything UI-related:
- `bloc/`: Business Logic Components – state management using BLoC pattern.
- `screen/`: Screens or pages shown to the user.
- `widgets/`: Reusable UI components specific to the `home` feature.

---


## Preview

| Page          | Android                                                                                   | IOS                                                                                       |
| ------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Home Page     | ![Image](https://github.com/user-attachments/assets/43a51af3-076a-481d-b772-ff12da3701eb) | ![Image](https://github.com/user-attachments/assets/9308eb11-bdaf-4fb4-9353-43939f13a58b) |
| Detail Page   | ![Image](https://github.com/user-attachments/assets/be36feaf-91f2-45fa-bcb7-74aa49521d6a) | ![Image](https://github.com/user-attachments/assets/f617a475-c0a4-455c-a780-3770bc120759) |
| Bookmark Page | ![Image](https://github.com/user-attachments/assets/07e19ca5-5875-4752-9d27-27db5dba4f0b) | ![Image](https://github.com/user-attachments/assets/eb5980e4-8b1c-4570-86c1-6a85c2a6c901) |
