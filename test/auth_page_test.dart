import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noorulmustakeem/features/authentication/auth_page.dart';

void main() {
  testWidgets('Login and Sign Up Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthPage(),
      ),
    );

    // Verify initial state is login
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Sign Up'), findsNothing);

    // Enter email and password
    await tester.enterText(
        find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // Tap the login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    // Verify login action
    // Removed expectation for print statement as it does not appear in the widget tree.

    // Switch to sign up
    await tester.tap(find.byKey(const Key('toggleFormModeButton')));
    await tester.pumpAndSettle();

    // Verify state is sign up
    final allTexts = find
        .byType(Text)
        .evaluate()
        .map((e) => (e.widget as Text).data)
        .toList();
    debugPrint('All Text widgets: $allTexts');
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Login'), findsNothing);

    // Tap the sign up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify sign up action
    // Removed expectation for print statement as it does not appear in the widget tree.
  });
}
