import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:IEMPhysics/home_page.dart';
import 'package:IEMPhysics/lab_page.dart';
import 'package:IEMPhysics/theory_page.dart';
import 'package:IEMPhysics/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Home navigates to TheoryPage', (tester) async {
    final binding = tester.binding;
    binding.window.physicalSizeTestValue = const Size(1200, 2000);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(home: HomePage()),
      ),
    );

    await tester.tap(find.text('Theory'));
    await tester.pumpAndSettle();

    expect(find.byType(TheoryPage), findsOneWidget);
  });

  testWidgets('Home navigates to LabPage', (tester) async {
    final binding = tester.binding;
    binding.window.physicalSizeTestValue = const Size(1200, 2000);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(home: HomePage()),
      ),
    );

    await tester.tap(find.text('Lab'));
    await tester.pumpAndSettle();

    expect(find.byType(LabPage), findsOneWidget);
  });
}
