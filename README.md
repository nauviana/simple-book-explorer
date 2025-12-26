# Simple Book Explorer

Simple mobile app built with Flutter to display a list of books from a public API.
This project was created as part of a Mobile Engineer technical test.

## Features
- Show list of books with cover image
- Book detail page
- Fetch data from public API
- Handle cellular data offline / network error safely
- Retry when network is available again

## Tech Stack
- Flutter
- Riverpod (state management)
- Dio (networking)
- GoRouter (navigation)
- CachedNetworkImage

## Architecture
The project uses a simple MVVM-style structure:
- UI layer handles rendering only
- ViewModel handles state and logic
- Repository handles data source and error handling

This keeps the UI clean and easy to maintain.

## API
Data source:
https://openlibrary.org/subjects/love.json?limit=10

Fields used:
- title
- author
- cover_id

## Offline Handling
If the device has no internet connection:
- The app will not crash
- An error message is shown
- User can retry once the network is back

## How to Run
```bash
flutter pub get
flutter run
