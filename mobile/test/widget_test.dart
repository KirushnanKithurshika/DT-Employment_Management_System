import 'package:flutter_test/flutter_test.dart';
import 'package:ems_mobile/main.dart';

void main() {
  testWidgets('app renders the employee home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const EmsApp());

    expect(find.text('Employment Management System'), findsOneWidget);
    expect(find.text('Employee mobile app'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}