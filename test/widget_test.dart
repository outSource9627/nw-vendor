import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseryvendor/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NurseryWallahApp());

    // Verify that our splash screen is displayed.
    // Since text is now inside the logo image, we check for the Image widget instead.
    expect(find.byType(Image), findsWidgets);
    
    // Pump some time to clear the navigation timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
