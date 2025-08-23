import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'theme_provider.dart';

// Material 3 Motion Specifications
const Duration kThemeAnimationDuration = Duration(milliseconds: 200);
const Curve kThemeAnimationCurve = Curves.easeInOutCubicEmphasized;

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
               foregroundColor: lightColorScheme.onPrimaryContainer,
               elevation: 0,
               shadowColor: lightColorScheme.shadow,
               surfaceTintColor: lightColorScheme.primaryContainer,
             ),
             pageTransitionsTheme: const PageTransitionsTheme(
               builders: {
                 TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
                 TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                 TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                 TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                 TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
               },
             ),
             splashFactory: InkSparkle.splashFactory,
             highlightColor: lightColorScheme.primary.withValues(alpha: 0.08),
             focusColor: lightColorScheme.primary.withValues(alpha: 0.12),
             hoverColor: lightColorScheme.primary.withValues(alpha: 0.04),
             textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme).copyWith(
               displayLarge: GoogleFonts.lato(
                 fontSize: 57,
                 fontWeight: FontWeight.w400,
                 height: 1.12,
                 letterSpacing: -0.25,
               ),
               displayMedium: GoogleFonts.lato(
                 fontSize: 45,
                 fontWeight: FontWeight.w400,
                 height: 1.16,
                 letterSpacing: 0,
               ),
               displaySmall: GoogleFonts.lato(
                 fontSize: 36,
                 fontWeight: FontWeight.w400,
                 height: 1.22,
                 letterSpacing: 0,
               ),
               headlineLarge: GoogleFonts.lato(
                 fontSize: 32,
                 fontWeight: FontWeight.w400,
                 height: 1.25,
                 letterSpacing: 0,
               ),
               headlineMedium: GoogleFonts.lato(
                 fontSize: 28,
                 fontWeight: FontWeight.w400,
                 height: 1.29,
                 letterSpacing: 0,
               ),
               headlineSmall: GoogleFonts.lato(
                 fontSize: 24,
                 fontWeight: FontWeight.w400,
                 height: 1.33,
                 letterSpacing: 0,
               ),
               titleLarge: GoogleFonts.lato(
                 fontSize: 22,
                 fontWeight: FontWeight.w500,
                 height: 1.27,
                 letterSpacing: 0,
               ),
               titleMedium: GoogleFonts.lato(
                 fontSize: 16,
                 fontWeight: FontWeight.w500,
                 height: 1.5,
                 letterSpacing: 0.15,
               ),
               titleSmall: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
                 height: 1.43,
                 letterSpacing: 0.1,
               ),
               bodyLarge: GoogleFonts.lato(
                 fontSize: 16,
                 fontWeight: FontWeight.w400,
                 height: 1.5,
                 letterSpacing: 0.5,
               ),
               bodyMedium: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
                 height: 1.43,
                 letterSpacing: 0.25,
               ),
               bodySmall: GoogleFonts.lato(
                 fontSize: 12,
                 fontWeight: FontWeight.w400,
                 height: 1.33,
                 letterSpacing: 0.4,
               ),
               labelLarge: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
                 height: 1.43,
                 letterSpacing: 0.1,
               ),
               labelMedium: GoogleFonts.lato(
                 fontSize: 12,
                 fontWeight: FontWeight.w500,
                 height: 1.33,
                 letterSpacing: 0.5,
               ),
               labelSmall: GoogleFonts.lato(
                 fontSize: 11,
                 fontWeight: FontWeight.w500,
                 height: 1.45,
                 letterSpacing: 0.5,
               ),
             ),
           ),
           darkTheme: ThemeData(
             useMaterial3: true,
             colorScheme: darkColorScheme,
             appBarTheme: AppBarTheme(
               backgroundColor: darkColorScheme.primaryContainer,
               foregroundColor: darkColorScheme.onPrimaryContainer,
               elevation: 0,
               shadowColor: darkColorScheme.shadow,
               surfaceTintColor: darkColorScheme.primaryContainer,
             ),
             pageTransitionsTheme: const PageTransitionsTheme(
               builders: {
                 TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
                 TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                 TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                 TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                 TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
               },
             ),
             splashFactory: InkSparkle.splashFactory,
             highlightColor: darkColorScheme.primary.withValues(alpha: 0.08),
             focusColor: darkColorScheme.primary.withValues(alpha: 0.12),
             hoverColor: darkColorScheme.primary.withValues(alpha: 0.04),
             textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme).copyWith(
               displayLarge: GoogleFonts.lato(
                 fontSize: 57,
                 fontWeight: FontWeight.w400,
                 height: 1.12,
                 letterSpacing: -0.25,
               ),
               displayMedium: GoogleFonts.lato(
                 fontSize: 45,
                 fontWeight: FontWeight.w400,
                 height: 1.16,
                 letterSpacing: 0,
               ),
               displaySmall: GoogleFonts.lato(
                 fontSize: 36,
                 fontWeight: FontWeight.w400,
                 height: 1.22,
                 letterSpacing: 0,
               ),
               headlineLarge: GoogleFonts.lato(
                 fontSize: 32,
                 fontWeight: FontWeight.w400,
                 height: 1.25,
                 letterSpacing: 0,
               ),
               headlineMedium: GoogleFonts.lato(
                 fontSize: 28,
                 fontWeight: FontWeight.w400,
                 height: 1.29,
                 letterSpacing: 0,
               ),
               headlineSmall: GoogleFonts.lato(
                 fontSize: 24,
                 fontWeight: FontWeight.w400,
                 height: 1.33,
                 letterSpacing: 0,
               ),
               titleLarge: GoogleFonts.lato(
                 fontSize: 22,
                 fontWeight: FontWeight.w500,
                 height: 1.27,
                 letterSpacing: 0,
               ),
               titleMedium: GoogleFonts.lato(
                 fontSize: 16,
                 fontWeight: FontWeight.w500,
                 height: 1.5,
                 letterSpacing: 0.15,
               ),
               titleSmall: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
                 height: 1.43,
                 letterSpacing: 0.1,
               ),
               bodyLarge: GoogleFonts.lato(
                 fontSize: 16,
                 fontWeight: FontWeight.w400,
                 height: 1.5,
                 letterSpacing: 0.5,
               ),
               bodyMedium: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
                 height: 1.43,
                 letterSpacing: 0.25,
               ),
               bodySmall: GoogleFonts.lato(
                 fontSize: 12,
                 fontWeight: FontWeight.w400,
                 height: 1.33,
                 letterSpacing: 0.4,
               ),
               labelLarge: GoogleFonts.lato(
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
                 height: 1.43,
                 letterSpacing: 0.1,
               ),
               labelMedium: GoogleFonts.lato(
                 fontSize: 12,
                 fontWeight: FontWeight.w500,
                 height: 1.33,
                 letterSpacing: 0.5,
               ),
               labelSmall: GoogleFonts.lato(
                 fontSize: 11,
                 fontWeight: FontWeight.w500,
                 height: 1.45,
                 letterSpacing: 0.5,
               ),
             ),
           ),
          home: const HomePage(),
        );
      },
    );
  }
}