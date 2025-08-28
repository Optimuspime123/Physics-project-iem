import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:IEMPhysics/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('ThemeProvider toggles theme mode', () async {
    SharedPreferences.setMockInitialValues({});
    final provider = ThemeProvider();
    // Allow async constructor to complete
    await Future.delayed(Duration.zero);
    expect(provider.themeMode, ThemeMode.light);

    provider.toggleTheme();
    expect(provider.themeMode, ThemeMode.dark);

    provider.toggleTheme();
    expect(provider.themeMode, ThemeMode.light);
  });
}
