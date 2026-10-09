import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/store/models/product.dart';
import 'package:zenith_wellness/features/store/providers/store_provider.dart';

void main() {
  group('StoreProvider Unit Tests', () {
    late StoreProvider provider;

    setUp(() {
      provider = StoreProvider();
    });

    test('Initial store products catalog is populated', () {
      expect(provider.products.isNotEmpty, true);
      expect(provider.products.length, 5);
      expect(provider.cartItems.isEmpty, true);
      expect(provider.totalItemCount, 0);
    });

    test('Adding product to cart increases quantity and recalculates totals', () {
      final product = provider.products.first; // Price: 49.99
      provider.addToCart(product);

      expect(provider.cartItems.containsKey(product.id), true);
      expect(provider.cartItems[product.id]!.quantity, 1);
      expect(provider.totalItemCount, 1);
      expect(provider.subtotal, closeTo(49.99, 0.01));

      // Add same product again
      provider.addToCart(product);
      expect(provider.cartItems[product.id]!.quantity, 2);
      expect(provider.totalItemCount, 2);
      expect(provider.subtotal, closeTo(99.98, 0.01));
    });

    test('Updating quantity and removing items from cart works properly', () {
      final p1 = provider.products[0];
      final p2 = provider.products[1];

      provider.addToCart(p1);
      provider.addToCart(p2);
      expect(provider.totalItemCount, 2);

      provider.updateQuantity(p1.id, 3);
      expect(provider.cartItems[p1.id]!.quantity, 3);
      expect(provider.totalItemCount, 4);

      // Decrementing to 0 removes the item
      provider.updateQuantity(p2.id, 0);
      expect(provider.cartItems.containsKey(p2.id), false);
      expect(provider.totalItemCount, 3);

      provider.removeFromCart(p1.id);
      expect(provider.cartItems.isEmpty, true);
    });

    test('Applying valid promo code ZENITH20 gives 20% discount', () {
      final product = provider.products.first; // 49.99
      provider.addToCart(product);

      final success = provider.applyPromoCode('ZENITH20');
      expect(success, true);
      expect(provider.discountPercent, 20.0);
      expect(provider.appliedPromoCode, 'ZENITH20');

      const expectedDiscount = 49.99 * 0.20;
      expect(provider.discountAmount, closeTo(expectedDiscount, 0.01));

      const netBeforeTax = 49.99 - expectedDiscount;
      const expectedTax = netBeforeTax * 0.05;
      expect(provider.taxAmount, closeTo(expectedTax, 0.01));
      expect(provider.totalAmount, closeTo(netBeforeTax + expectedTax, 0.01));
    });

    test('Applying invalid promo code fails and preserves original subtotal', () {
      final success = provider.applyPromoCode('FAKE_CODE_123');
      expect(success, false);
      expect(provider.discountPercent, 0.0);
      expect(provider.appliedPromoCode, isNull);
    });

    test('Clearing cart empties items and resets discounts', () {
      provider.addToCart(provider.products.first);
      provider.applyPromoCode('ZENITH20');

      provider.clearCart();
      expect(provider.cartItems.isEmpty, true);
      expect(provider.totalItemCount, 0);
      expect(provider.subtotal, 0.0);
      expect(provider.appliedPromoCode, isNull);
    });

    test('Filtering products by category returns matching products', () {
      provider.setCategoryFilter(ProductCategory.equipment);
      expect(provider.filteredProducts.every((p) => p.category == ProductCategory.equipment), true);
    });
  });
}
