# Magic Workout - MVVM Architecture

A Flutter application for tracking workout sessions built using the **MVVM (Model-View-ViewModel)** architecture pattern with Riverpod for state management and GoRouter for navigation.

## Features

- **Workout List Screen**: View all recorded workouts with summary information
- **Sets Detail Screen**: Add, edit, and delete individual sets within a workout
- **Exercise Selection**: Choose from 5 predefined exercises (Barbell row, Bench press, Shoulder press, Deadlift, Squat)
- **Data Persistence**: Uses SharedPreferences to save all data locally
- **Intuitive UI**: Clean, Material Design interface

### Workout List Screen:

- Shows all saved workouts with date and set count
- Delete functionality with confirmation dialog
- Sorted by date (newest first)
- Empty state guidance for new users

### Sets Screen:

- Add/remove sets dynamically
- Input validation for workout names
- Real-time updates as you type
- Edit existing workouts with all original data

## Architecture Choices

### State Management - Riverpod

I chose **Riverpod** for state management because:

- **Testability**: Easy to mock and test providers in isolation
- **Performance**: Optimized rebuilds and automatic disposal of unused providers

### Navigation - GoRouter

I selected **GoRouter** for navigation because:

- **Declarative Routing**: Type-safe route definitions with path parameters
- **Deep Linking**: Built-in support for web URLs and deep links
- **Integration**: Seamless integration with Riverpod for state-aware routing

### Data Models

The app uses three main models:

1. **Exercise** (Enum): Predefined exercise types with display names
2. **Set Module**: Individual set with exercise, weight, and repetitions
3. **Workout Module**: Container for multiple sets with date and metadata

## Comprehensive Testing:

- **Unit Tests** Model validation, JSON serialization, service logic
- **Widget Tests** UI components, navigation, user interactions
- **Integration Tests** Complete user workflow from creation to deletion



## Third-Party Dependencies

### Core Dependencies
- **flutter_riverpod** (^2.6.1): MVVM state management with excellent performance
- **go_router** (^16.1.0): Declarative routing with deep linking support
- **uuid** (^4.5.1): Generate unique identifiers for entities
- **shared_preferences** (^2.5.3): Save data locally

### Development Dependencies
- **integration_test** Integration Testing
- **flutter_lints** (^3.0.0): Official Flutter linting rules

## Getting Started

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd workout_tracker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run code generation (if needed):
```bash
dart run build_runner build
```

4. Run the app:
```bash
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run unit tests only
flutter test test/unit/

# Run widget tests only
flutter test test/widget/

# Run integration tests
flutter test integration_test/
```
