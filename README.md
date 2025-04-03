# Flutter UI Components Showcase

A desktop application that showcases ready-to-use Flutter UI components with their source code. This app is designed to help Flutter developers quickly find and implement common UI components in their projects.

## Features

- Browse UI components by category
- View component previews
- See component source code with syntax highlighting
- Copy code snippets to clipboard
- Desktop-optimized interface

## Categories of Components

The app currently includes the following categories of components:

- **Buttons**: Elevated, Outlined, and Text buttons
- **Text Fields**: Basic and Password input fields
- **Cards**: Basic cards and cards with images
- **Dialogs**: Alert dialogs

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run -d windows` (or your preferred desktop platform)

## Adding New Components

To add new components, modify the `ComponentProvider` class in `lib/providers/component_provider.dart`.

## Dependencies

- flutter_highlight: For code syntax highlighting
- flutter_syntax_view: For code display
- google_fonts: For improved typography
- provider: For state management
