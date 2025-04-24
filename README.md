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
2. Clone the project `https://github.com/Ashwin1002/news_demo.git`
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

## Preview

| Page          | Android                                                                                   | IOS                                                                                       |
| ------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Home Page     | ![Image](https://github.com/user-attachments/assets/43a51af3-076a-481d-b772-ff12da3701eb) | ![Image](https://github.com/user-attachments/assets/9308eb11-bdaf-4fb4-9353-43939f13a58b) |
| Detail Page   | ![Image](https://github.com/user-attachments/assets/be36feaf-91f2-45fa-bcb7-74aa49521d6a) | ![Image](https://github.com/user-attachments/assets/f617a475-c0a4-455c-a780-3770bc120759) |
| Bookmark Page | ![Image](https://github.com/user-attachments/assets/07e19ca5-5875-4752-9d27-27db5dba4f0b) | ![Image](https://github.com/user-attachments/assets/eb5980e4-8b1c-4570-86c1-6a85c2a6c901) |
