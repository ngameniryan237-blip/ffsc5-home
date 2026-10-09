import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/store/models/cart_item.dart';
import 'package:zenith_wellness/features/store/models/product.dart';
import 'package:zenith_wellness/features/store/presentation/widgets/cart_item_tile.dart';

void main() {
  group('CartItemTile Widget Tests', () {
    testWidgets('Renders product info, handles quantity change and deletion', (WidgetTester tester) async {
      int newQty = 0;
      bool removeCalled = false;

      const product = Product(
        id: 'p_test',
        title: 'Organic Whey Isolate',
        description: 'Clean protein powder',
        price: 49.99,
        category: ProductCategory.nutrition,
        rating: 4.9,
        reviewCount: 120,
      );

      const cartItem = CartItem(product: product, quantity: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartItemTile(
              item: cartItem,
              onQuantityChanged: (qty) => newQty = qty,
              onRemove: () => removeCalled = true,
            ),
          ),
        ),
      );

      expect(find.text('Organic Whey Isolate'), findsOneWidget);
      expect(find.text('\$49.99 each'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      // Increment
      await tester.tap(find.byIcon(Icons.add));
      expect(newQty, 3);

      // Decrement
      await tester.tap(find.byIcon(Icons.remove));
      expect(newQty, 1);

      // Remove button
      await tester.tap(find.byIcon(Icons.close));
      expect(removeCalled, true);
    });
  });
}
