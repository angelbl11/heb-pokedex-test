# 🎮 Pokédex App

A modern, animated Flutter application that provides a comprehensive Pokédex experience with beautiful animations and smooth user interactions.

![Pokédex App](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-lightgrey?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## ✨ Features

- **🎯 Complete Pokédex**: Browse through all Pokémon with pagination
- **🔍 Smart Search**: Search by name, ID, or formatted ID (#001)
- **📱 Responsive Design**: Works seamlessly across all platforms
- **🎨 Beautiful Animations**: Smooth transitions and entrance effects
- **🔄 Real-time Data**: Fetches data from the official PokéAPI
- **📊 Detailed Information**: Complete stats, abilities, and type information
- **🎭 Hero Transitions**: Smooth image transitions between screens
- **✨ Shimmer Loading**: Elegant loading states with shimmer effects

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.0 or higher
- **Dart SDK**: 3.0 or higher
- **Android Studio** / **VS Code** with Flutter extensions
- **Git**

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/pokedex_app.git
   cd pokedex_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android

- Ensure Android SDK is properly configured
- Enable USB debugging on your device
- Run `flutter doctor` to verify setup

#### iOS

- Install Xcode and iOS Simulator
- Run `flutter doctor` to verify setup
- For physical device: Configure signing in Xcode

#### Web

- Run `flutter config --enable-web`
- Use `flutter run -d chrome`

#### Desktop

- Run `flutter config --enable-windows` (Windows)
- Run `flutter config --enable-macos` (macOS)
- Run `flutter config --enable-linux` (Linux)

## 🏗️ Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── errors/                    # Error handling
│   └── network/                   # Network configuration
├── data/                          # Data layer
│   ├── datasources/               # Remote data sources
│   ├── models/                    # Data models
│   └── repositories/              # Repository implementations
├── domain/                        # Business logic
│   ├── entities/                  # Business entities
│   └── repositories/              # Repository interfaces
├── presentation/                  # UI layer
│   ├── pages/                     # Screen implementations
│   ├── state/                     # State management
│   ├── theme/                     # App theming and animations
│   └── widgets/                   # Reusable UI components
└── main.dart                      # Application entry point
```

## 🎨 Architecture

The application follows **Clean Architecture** principles with **Riverpod** for state management:

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repositories
- **Core Layer**: Shared utilities and configurations

### State Management

- **Riverpod**: Modern state management solution
- **Providers**: Organized by feature and functionality
- **Controllers**: Handle business logic and API calls
- **State Classes**: Immutable state representations

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
POKEAPI_BASE_URL=https://pokeapi.co/api/v2
POKEAPI_TIMEOUT=30000

# App Configuration
APP_NAME=Pokédex
APP_VERSION=1.0.0
```

### Network Configuration

The app uses **Dio** for HTTP requests with:

- Base URL: `https://pokeapi.co/api/v2`
- Timeout: 30 seconds
- Error handling and retry logic

## 📱 Screenshots

### Home Screen

- Grid layout with Pokémon cards
- Search functionality
- Sort options (by name or ID)
- Pull-to-refresh support

### Detail Screen

- Hero image with smooth transitions
- Type information with color coding
- Base stats with animated progress bars
- Abilities and characteristics

## 🎬 Animations

The app features a comprehensive animation system:

### Page Transitions

- **Slide from bottom**: Main navigation
- **Slide from right**: Side navigation
- **Fade with scale**: Modals and overlays
- **Slide with fade**: Detail pages

### Card Animations

- **Staggered entrance**: Cards appear sequentially
- **Hover effects**: Scale and shadow animations
- **Tap feedback**: Bounce animations

### Loading States

- **Shimmer effects**: Smooth loading animations
- **Progressive loading**: Content appears in stages

For detailed animation documentation, see [ANIMATIONS_README.md](ANIMATIONS_README.md).

## 🧪 Testing

The app includes a comprehensive testing suite with unit tests, widget tests, and integration tests.

### Quick Start

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test categories
flutter test test/domain/          # Business logic tests
flutter test test/presentation/    # UI component tests
flutter test integration_test/     # End-to-end tests
```

### Test Structure

- **Unit Tests**: Business logic, entities, and utilities
- **Widget Tests**: Individual UI components and interactions
- **Integration Tests**: Complete app flows and user journeys
- **Test Coverage**: >90% unit tests, >80% widget tests

### Test Documentation

For detailed testing information, see [test/README.md](test/README.md).

### Test Examples

```bash
# Run only failing tests
flutter test --reporter=expanded

# Run tests in debug mode
flutter test --debug

# Run tests with verbose output
flutter test --verbose
```

## 📦 Dependencies

### Core Dependencies

- **flutter**: UI framework
- **riverpod**: State management
- **dio**: HTTP client
- **freezed**: Code generation for immutable classes

### Development Dependencies

- **build_runner**: Code generation
- **riverpod_generator**: Riverpod code generation
- **freezed_annotation**: Freezed annotations

## 🚀 Building for Production

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

### Desktop

```bash
flutter build windows --release  # Windows
flutter build macos --release    # macOS
flutter build linux --release    # Linux
```

## 🔍 Troubleshooting

### Common Issues

1. **Build errors**

   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Animation performance issues**

   - Check device performance
   - Reduce animation complexity
   - Use `flutter run --profile` for testing

3. **Network issues**
   - Verify internet connection
   - Check API endpoint availability
   - Review network configuration

### Debug Mode

Enable debug mode for development:

```bash
flutter run --debug
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter best practices
- Maintain clean architecture principles
- Write comprehensive tests
- Update documentation as needed
- Use conventional commit messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **PokéAPI**: For providing comprehensive Pokémon data
- **Flutter Team**: For the amazing framework
- **Riverpod**: For excellent state management
- **Community**: For contributions and feedback

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/pokedex_app/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/pokedex_app/discussions)
- **Email**: your.email@example.com

---

**Made with ❤️ and Flutter**

_Catch 'em all!_ 🎯✨
