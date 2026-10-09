import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/app.dart';

void main() {
  group('E2E Store & Checkout Flow Integration Test', () {
    testWidgets('Complete user journey: Browse products, add to cart, apply coupon, and complete checkout', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ZenithApp());
      await tester.pumpAndSettle();

      // 1. Navigate to Store tab
      await tester.tap(find.byIcon(Icons.storefront_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Wellness Marketplace'), findsOneWidget);

      // 2. Add first product to cart
      final addToCartButton = find.byIcon(Icons.add_shopping_cart).first;
      await tester.tap(addToCartButton);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

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

      // Wait for SnackBar duration to complete so it doesn't overlap the bottom button
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // Tap Proceed to Checkout
      final checkoutButton = find.widgetWithText(ElevatedButton, 'Proceed to Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      // Verify Success Dialog
      expect(find.text('Order Placed Successfully!'), findsOneWidget);

      // Tap Done
      await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
      await tester.pumpAndSettle();

      // Verify returned to Store screen
      expect(find.text('Wellness Marketplace'), findsOneWidget);
    });
  });
}
