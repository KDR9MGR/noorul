import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noorulmustakeem/features/authentication/auth_page.dart';

void main() {
  testWidgets('Login and Sign Up Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(),
      ),
    );

    // Verify initial state is login
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsNothing);

    // Enter email and password
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pump();

    // Verify login action
    expect(find.text('Logging in with email: test@example.com'), findsOneWidget);

    // Switch to sign up
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify state is sign up
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Login'), findsNothing);

    // Tap the sign up button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify sign up action
    expect(find.text('Signing up with email: test@example.com'), findsOneWidget);
  });
} 