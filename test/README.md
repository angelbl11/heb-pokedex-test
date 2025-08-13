# 🧪 Testing Guide - Pokédex App

This document provides comprehensive information about testing the Pokédex app, including how to run tests, test structure, and best practices.

## 📁 Test Structure

```
test/
├── README.md                           # This file
├── run_tests.dart                      # Test runner configuration
├── test_config.dart                    # Test utilities and configuration
├── widget_test.dart                    # Main app widget tests
├── domain/                             # Domain layer tests
│   └── entities/                       # Entity tests
│       ├── pokemon_summary_test.dart   # PokemonSummary entity tests
│       └── pokemon_list_state_test.dart # PokemonListState entity tests
├── presentation/                       # Presentation layer tests
│   ├── widgets/                        # Widget tests
│   │   ├── pokemon_card_test.dart     # PokemonCard widget tests
│   │   └── shimmer_loading_test.dart  # ShimmerLoading widget tests
│   └── theme/                          # Theme and animation tests
│       └── page_transitions_test.dart # Page transition tests
└── integration_test/                   # Integration tests
    └── app_test.dart                   # End-to-end app tests
```

## 🚀 Running Tests

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Specific Test Files

```bash
# Run only widget tests
flutter test test/widget_test.dart

# Run only domain tests
flutter test test/domain/

# Run only presentation tests
flutter test test/presentation/

# Run only integration tests
flutter test integration_test/
```

### Run Tests with Verbose Output

```bash
flutter test --verbose
```

### Run Tests with Custom Reporter

```bash
flutter test --reporter=expanded
```

### Run Tests in Debug Mode

```bash
flutter test --debug
```

## 📊 Test Coverage

The app includes comprehensive test coverage across all layers:

### Domain Layer (Business Logic)

- **PokemonSummary Entity**: Tests for entity creation, properties, and validation
- **PokemonListState Entity**: Tests for state management, loading states, and error handling

### Presentation Layer (UI)

- **Widget Tests**: Tests for individual UI components
- **Theme Tests**: Tests for page transitions and animations
- **Integration Tests**: End-to-end app functionality tests

### Test Coverage Goals

- **Unit Tests**: >90% coverage
- **Widget Tests**: >80% coverage
- **Integration Tests**: Critical user flows

## 🧩 Test Types

### 1. Unit Tests

Test individual functions, methods, and classes in isolation.

**Example:**

```dart
test('should create PokemonSummary with correct values', () {
  const pokemon = PokemonSummary(
    id: 1,
    name: 'bulbasaur',
    imageUrl: 'https://example.com/bulbasaur.png',
  );

  expect(pokemon.id, equals(1));
  expect(pokemon.name, equals('bulbasaur'));
});
```

### 2. Widget Tests

Test individual widgets and their interactions.

**Example:**

```dart
testWidgets('should render PokemonCard with correct information', (WidgetTester tester) async {
  await tester.pumpWidget(createTestWidget());
  await tester.pumpAndSettle();

  expect(find.text('Bulbasaur'), findsOneWidget);
  expect(find.text('#001'), findsOneWidget);
});
```

### 3. Integration Tests

Test complete app flows and user interactions.

**Example:**

```dart
testWidgets('Complete app flow test', (WidgetTester tester) async {
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();

  expect(find.byType(MaterialApp), findsOneWidget);
  expect(find.text('Pokédex'), findsOneWidget);
});
```

## 🛠️ Test Utilities

### TestConfig Class

Provides utility methods for common testing tasks:

```dart
// Create test app with ProviderScope
final app = TestConfig.createTestApp(child: testWidget);

// Wait for animations
await TestConfig.waitForAnimations(tester);

// Find widgets safely
final widget = TestConfig.findWidget<MyWidget>(tester);

// Tap and wait
await TestConfig.tapAndWait(tester, finder);
```

### TestData Class

Provides sample data for testing:

```dart
// Sample Pokémon names
final names = TestData.samplePokemonNames;

// Sample search queries
final queries = TestData.sampleSearchQueries;

// Sample error messages
final errors = TestData.sampleErrorMessages;
```

## 📝 Writing Tests

### Test Naming Convention

Use descriptive names that explain what is being tested:

```dart
test('should handle empty search query gracefully', () { ... });
test('should display error message when API fails', () { ... });
test('should navigate to detail page on card tap', () { ... });
```

### Test Structure

Follow the Arrange-Act-Assert pattern:

```dart
test('should filter Pokémon by name', () {
  // Arrange
  final pokemon = createTestPokemon();
  final filter = 'bulba';

  // Act
  final result = filterPokemon(pokemon, filter);

  // Assert
  expect(result, contains(pokemon));
});
```

### Widget Test Best Practices

1. **Wait for animations**: Use `tester.pumpAndSettle()` after interactions
2. **Handle async operations**: Use `Future.delayed` or `pump` for timers
3. **Test user interactions**: Tap, scroll, and enter text to test functionality
4. **Verify state changes**: Check that UI updates correctly after interactions

## 🔧 Test Configuration

### Mock Classes

For testing dependencies, create mock classes:

```dart
class MockPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<List<PokemonSummary>> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    return [createTestPokemon()];
  }
}
```

### Test Providers

Override providers for testing:

```dart
final testProvider = Provider<PokemonRepository>((ref) {
  return MockPokemonRepository();
});

await tester.pumpWidget(
  ProviderScope(
    overrides: [
      pokemonRepositoryProvider.overrideWithProvider(testProvider),
    ],
    child: const App(),
  ),
);
```

## 🚨 Common Issues and Solutions

### Timer Pending Errors

**Problem**: Tests fail with "Timer is still pending" errors.

**Solution**: Use `tester.pumpAndSettle()` to wait for all timers to complete.

### Widget Not Found Errors

**Problem**: Tests can't find expected widgets.

**Solution**: Ensure the widget tree is fully built and wait for async operations.

### Provider Errors

**Problem**: Tests fail due to missing providers.

**Solution**: Wrap test widgets with `ProviderScope` and provide necessary dependencies.

## 📈 Continuous Integration

### GitHub Actions

The app includes GitHub Actions for automated testing:

```yaml
- name: Run tests
  run: flutter test --coverage

- name: Upload coverage
  uses: codecov/codecov-action@v3
```

### Pre-commit Hooks

Run tests before committing:

```bash
# Install pre-commit hooks
pre-commit install

# Run tests manually
flutter test
```

## 🎯 Testing Checklist

Before committing code, ensure:

- [ ] All existing tests pass
- [ ] New functionality has corresponding tests
- [ ] Test coverage is maintained or improved
- [ ] Tests are descriptive and maintainable
- [ ] Integration tests cover critical user flows
- [ ] Performance tests are included for new features

## 📚 Additional Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Flutter Widget Testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [Flutter Integration Testing](https://docs.flutter.dev/cookbook/testing/integration/introduction)
- [Riverpod Testing](https://riverpod.dev/docs/cookbooks/testing)

---

**Remember**: Good tests are the foundation of maintainable code. Write tests that are clear, comprehensive, and help catch regressions early.
