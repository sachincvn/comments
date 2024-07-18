# Comments App

A Flutter application that allows users to authenticate using Firebase, fetches and displays comments from an external API, and conditionally masks email addresses based on Firebase Remote Config settings. This project was developed to demonstrate proficiency in mobile development, state management, and Firebase integration.

## Features

- **Firebase Authentication**: Users can register and sign in using their email. Upon registration, user details (name, email) are collected and stored in Firestore.
- **Comments Feed**: Displays a list of comments fetched from [JSONPlaceholder](https://jsonplaceholder.typicode.com/comments).
- **Conditional Email Display**: Uses Firebase Remote Config to determine whether to display the full email or a masked version in the comments feed.
- **Pagination**: Efficiently handles large sets of comments with pagination.
- **Form Validation**: Ensures proper input validation for user registration and login forms.
- **Error Handling**: Comprehensive error handling for API and Firebase interactions.

## Project Structure

The project follows a clean and scalable architecture, ensuring separation of concerns and maintainability. Here is an overview of the folder structure:

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── utils/
│   ├── errors/
│   ├── usecases/
├── data/
│   ├── datasources/
│   ├── models/
│   ├── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   ├── usecases/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   ├── providers/
│   ├── routes/
└── main.dart

```

### Core

- **constants/**: Contains constant values used throughout the application.
- **utils/**: Utility functions and helpers.
- **errors/**: Custom error classes for handling exceptions.

### Data

- **datasources/**: Responsible for data retrieval from APIs and local storage.
- **models/**: Data models representing the structure of the data.
- **repositories/**: Implementation of repository interfaces defined in the domain layer.

### Domain

- **entities/**: Core data structures representing business objects.
- **repositories/**: Abstract definitions of data operations.
- **usecases/**: Interactors encapsulating the application's business rules.

### Presentation

- **pages/**: UI screens and pages.
- **widgets/**: Reusable UI components.
- **providers/**: State management and dependency injection.
- **routes/**: Application navigation and route definitions.

### Main Entry Point

- **main.dart**: The main entry point of the application, responsible for initializing dependencies and running the app.
