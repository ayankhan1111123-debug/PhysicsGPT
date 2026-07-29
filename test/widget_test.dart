import 'package:flutter_test/flutter_test.dart';
import 'package:physicsgpt/main.dart';

void main() {
  testWidgets('PhysicsGPT launches successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PhysicsGPT());

    expect(find.text('PhysicsGPT'), findsOneWidget);
  });
}