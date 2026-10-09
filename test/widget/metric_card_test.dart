import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/core/widgets/metric_card.dart';

void main() {
  group('MetricCard Widget Tests', () {
    testWidgets('Renders title, value, subtitle, and responds to tap', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetricCard(
              title: 'Water Logged',
              value: '2250 ml',
              subtitle: '90% of goal',
              icon: Icons.water_drop,
              accentColor: Colors.blue,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Water Logged'), findsOneWidget);
      expect(find.text('2250 ml'), findsOneWidget);
      expect(find.text('90% of goal'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);

      await tester.tap(find.byType(MetricCard));
      expect(tapped, true);
    });
  });
}
