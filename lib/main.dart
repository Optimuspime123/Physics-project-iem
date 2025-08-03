import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color.fromARGB(255, 26, 82, 118);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Define color schemes separately to access their properties
        final lightColorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        );

        final darkColorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

        return MaterialApp(
          title: 'IEM Salt Lake Physics App',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            appBarTheme: AppBarTheme(
              backgroundColor: lightColorScheme.primaryContainer,
              foregroundColor: lightColorScheme.onPrimaryContainer, // Ensures text and icons are readable
            ),
            textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            appBarTheme: AppBarTheme(
              backgroundColor: darkColorScheme.primaryContainer,
              foregroundColor: darkColorScheme.onPrimaryContainer, // Ensures text and icons are readable
            ),
            textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}