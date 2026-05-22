# MovieDB Flutter App

Mobile application to explore movies and TV shows
using The Movie Database (TMDB) API.
Built with Flutter following Clean Architecture
and Spec-Driven Development methodology.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter + Dart | Mobile framework |
| Clean Architecture | Architectural pattern |
| Cubit (flutter_bloc) | State management |
| GetIt | Dependency injection |
| Dio | HTTP client |
| Freezed | Sealed classes and states |
| dartz | Functional error handling (Either) |
| go_router | Navigation |
| cached_network_image | Image caching |
| TMDB API | Data source |

---

## Architecture Overview

```bash
PRESENTATION  →  DOMAIN  ←  DATA
```

| Layer | Responsibility | Knows about |
|---|---|---|
| DOMAIN | Business rules, entities, contracts | Nothing external |
| DATA | TMDB API, models, repository impl | Domain |
| PRESENTATION | Cubits, states, pages, widgets | Domain |

**The golden rule:** dependencies always point inward.
Domain has zero external dependencies —
no Flutter, no Firebase, no Dio, no third-party libraries.

For the complete architecture specification see
[docs/architecture.md](docs/architecture.md)

---

## Project Structure

```bash
lib/
├── core/
│   ├── constants/          # API base URLs and keys
│   ├── error/              # Exceptions and Failures
│   ├── network/            # Dio client configuration
│   ├── usecases/           # Base Usecase<T,P> interface
│   └── router/             # App navigation with go_router
│
├── features/
│   └── media/
│       ├── domain/
│       │   ├── entities/       # Movie, TvShow, MediaDetail
│       │   ├── repositories/   # IMediaRepository interface
│       │   └── usecases/       # One class per user action
│       │
│       ├── data/
│       │   ├── datasources/    # TMDB API communication
│       │   ├── models/         # DTOs with fromJson + toEntity()
│       │   └── repositories/   # MediaRepositoryImpl
│       │
│       └── presentation/
│           ├── cubit/          # State management
│           ├── pages/          # App screens
│           └── widgets/        # Reusable components
│
├── injection_container.dart    # GetIt dependency registration
└── main.dart
```

---

## How to Run

### Requirements
- Flutter 3.41.9 or higher
- Dart 3.11.5 or higher
- Internet connection (TMDB API)

### Steps

**1. Clone the repository**

```bash
git clone https://github.com/Summy21/moviedb-flutter-app.git
cd moviedb-flutter-app
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Run code generator**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. Run the app**

```bash
flutter run
```

## Tests

### Running tests

```bash
flutter test
```

### Running tests with coverage

```bash
flutter test --coverage
```

### Test coverage

| Layer | What is tested |
|---|---|
| Domain — Use Cases | Correct delegation to repository |
| Data — Repository | Exception to Failure conversion |
| Data — Models | JSON parsing and toEntity() mapping |
| Presentation — Cubits | State emission sequence |

*(This section will be updated as tests are implemented)*
---

## Features Implemented

- [ ] Popular movies list
- [ ] Top rated movies list
- [ ] Popular TV shows list
- [ ] Top rated TV shows list
- [ ] Movie detail view
- [ ] TV show detail view
- [ ] Search by name
- [ ] Animations and transitions
- [ ] Unit tests

*(Updated as development progresses)*

---

## Pending Features

*(Completed at delivery)*

Any feature not fully implemented will be described here,
including how it would be approached with more time.

---

## Screenshots

*(Added at delivery)*

---

## Development Methodology

This project combines two complementary approaches:

**Agile principles**
- Incremental delivery — each commit represents
  a functional advancement
- Value-based prioritization — mandatory features
  first, optional features last
- Living documentation — architecture docs evolve
  with the code, not frozen after the first write

**Spec-Driven Development**
- Full system specification before writing code
- Defining the "what" and "why" before the "how"
- Result documented in [docs/architecture.md](docs/architecture.md)

These are not competing methodologies.
Agile organizes how work is delivered.
Spec-Driven Development ensures the right thing
is built before building it.

---

## AI Methodology

**Claude (Anthropic)** was used as a technical support tool
following Spec-Driven Development principles.

**1. Specification first**
Complete architecture, entities, contracts and state flows
were defined in writing before writing any code.
See [docs/architecture.md](docs/architecture.md)

**2. AI as a validation tool**
Claude was used to validate already-made design decisions,
resolve specific compilation errors, and verify Clean
Architecture principles were correctly applied.
Design decisions were mine — AI was a reviewer, not a generator.

**3. Understanding before implementing**
Every piece of code was reviewed, understood and adapted
to the project context.

**4. Technical decisions are mine**
Clean Architecture, Cubit, GetIt, Dio and the folder structure
are decisions based on experience developing Flutter
applications in production banking environments.

---

## Technical Decisions

| Decision | Alternative | Why |
|---|---|---|
| Cubit | Bloc | Simple flows, no complex event transformations |
| GetIt | Provider, Riverpod | Simple, no widget tree dependency |
| Dio | http package | Interceptors, centralized error handling |
| Freezed | Manual | Eliminates sealed class boilerplate |
| dartz Either | Exceptions | Forces explicit error handling at compile time |
| go_router | Navigator 2.0 | Declarative, cleaner named routes |
| cached_network_image | Image.network | Caching, placeholders, error widgets |

---

## References

- [TMDB API Documentation](https://developers.themoviedb.org/)
- [Flutter BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture — Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)