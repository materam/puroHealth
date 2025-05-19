import 'package:flutter_test/flutter_test.dart';
import 'package:stess_mange/main.dart';
import 'package:stess_mange/screens/home.dart'; // ✅ Add this import

void main() {
  testWidgets('SmartHealthcareApp renders HomePage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Now HomePage is recognized
    expect(find.byType(HomePage), findsOneWidget);
  });
}
