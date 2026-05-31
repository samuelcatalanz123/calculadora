import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora/main.dart';

void main() {
  testWidgets('la app arranca', (WidgetTester tester) async {
    await tester.pumpWidget(const MiApp());
  });
}
