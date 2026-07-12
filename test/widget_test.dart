import 'package:flutter_test/flutter_test.dart';
import 'package:phf_money_app/app.dart';

void main() {
  testWidgets('App should render correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MoneyApp());

    // Verify that our initial text is found.
    expect(find.text('PHF Money App is Running! 🚀'), findsOneWidget);
  });
}
