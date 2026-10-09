import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:zenith_wellness/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Store & Checkout Flow Integration Test', () {
    testWidgets('Full flow: browse catalog, add item to cart, apply promo code, and checkout', (WidgetTester tester) async {
      await tester.pumpWidget(const ZenithApp());
      await tester.pumpAndSettle();

      // 1. Navigate to Store tab
      await tester.tap(find.byIcon(Icons.storefront_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Wellness Marketplace'), findsOneWidget);

      // 2. Add first product to cart
      final addToCartButtons = find.byIcon(Icons.add_shopping_cart);
      expect(addToCartButtons, findsWidgets);
      await tester.tap(addToCartButtons.first);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // 3. Open Shopping Cart Screen via top AppBar action
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Shopping Cart'), findsOneWidget);

      // 4. Enter Promo Code ZENITH20
      final promoInput = find.byType(TextField).first;
      await tester.enterText(promoInput, 'ZENITH20');
      await tester.pumpAndSettle();

      // Tap Apply button
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      // Verify discount is applied
      expect(find.text('Discount (ZENITH20)'), findsOneWidget);

      // 5. Tap Proceed to Checkout
      await tester.tap(find.text('Proceed to Checkout'));
      await tester.pumpAndSettle();

      // Verify Success Dialog
      expect(find.text('Order Placed Successfully!'), findsOneWidget);

      // Tap Done
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      // Verify returned to Store screen
      expect(find.text('Wellness Marketplace'), findsOneWidget);
    });
  });
}
