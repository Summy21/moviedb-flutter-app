import 'package:flutter/material.dart';
import 'package:moviedb_flutter_app/core/router/app_router.dart';
import 'package:moviedb_flutter_app/injection_container.dart';

Future<void> main() async {
  // Ensures Flutter engine is initialized before calling
  // any platform-specific code or async operations.
  WidgetsFlutterBinding.ensureInitialized();

  // Register all dependencies before the app starts.
  await initDependencies();

  runApp(const MyApp());
}

/// Root application widget.
///
/// Stateless — all state is managed by Cubits.
/// Router configuration is handled by [AppRouter].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MovieDB',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      routerConfig: AppRouter.router,
    );
  }

  /// Dark theme inspired by streaming platform conventions.
  ///
  /// Color decisions:
  /// - Background: deep dark blue for cinematic feel
  /// - Primary: red accent for visual hierarchy
  /// - Surface: slightly lighter dark for card differentiation
  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFE50914),
        surface: Color(0xFF16213E),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      cardTheme: const CardThemeData(
        color: Color(0xFF16213E),
        elevation: 4,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: Color(0xFFE50914),
        unselectedLabelColor: Colors.white60,
        indicatorColor: Color(0xFFE50914),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFF16213E),
        selectedColor: Color(0xFFE50914),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}