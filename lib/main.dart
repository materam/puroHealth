import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/meditation_practice_screen.dart';
import 'screens/movement_practice.dart';
import 'screens/thank_you_screen.dart';

final themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        // Define base themes
        final ThemeData lightThemeBase = ThemeData.light();
        final ThemeData darkThemeBase = ThemeData.dark();

        return MaterialApp(
          title: 'Smart Health',
          theme: lightThemeBase.copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: lightThemeBase.colorScheme.copyWith(
              primary: Colors.lightBlueAccent,
              secondary: Colors.blueAccent,
            ),
            appBarTheme: lightThemeBase.appBarTheme.copyWith(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          darkTheme: darkThemeBase.copyWith(
            scaffoldBackgroundColor: const Color(0xFF10131A),
            colorScheme: darkThemeBase.colorScheme.copyWith(
              primary: Colors.lightBlueAccent,
              secondary: Colors.blueAccent,
              brightness: Brightness.dark,
            ),
            appBarTheme: darkThemeBase.appBarTheme.copyWith(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            textTheme: darkThemeBase.textTheme
                .apply(bodyColor: Colors.white70, displayColor: Colors.white)
                .copyWith(
                  headlineSmall: darkThemeBase.textTheme.headlineSmall
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  titleLarge: darkThemeBase.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  bodyMedium: darkThemeBase.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  labelLarge: darkThemeBase.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/meditation-practice': (context) => const MeditationPracticePage(),
            '/movement-practice': (context) => const MovementPracticeScreen(),
            '/thank-you': (context) => const ThankYouScreen(),
          },
        );
      },
    );
  }
}
