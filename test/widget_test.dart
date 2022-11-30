// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simantan/app/modules/auth/views/auth_view.dart';

import 'package:simantan/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AuthView());
    // make sure the widget is in the tree
    expect(find.byType(AuthView), findsOneWidget);
    // make sure the widget is visible
    expect(find.byType(AuthView).evaluate().first.widget, isA<AuthView>());
  });
}
