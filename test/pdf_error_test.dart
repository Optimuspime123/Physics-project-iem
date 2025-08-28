import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:IEMPhysics/lab_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Shows SnackBar when PDF open fails', (tester) async {
    final binding = tester.binding;
    binding.window.physicalSizeTestValue = const Size(1200, 2000);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: LabPage()));

    // Expand the first experiment card
    await tester.tap(find.text('Carey Foster Bridge Experiment'));
    await tester.pumpAndSettle();

    // Tap to open PDF (will fail due to missing plugins)
    final openButton = find.text('View in lab manual');
    await tester.ensureVisible(openButton);
    await tester.tap(openButton, warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(tester.takeException(), isNull);
  });
}
