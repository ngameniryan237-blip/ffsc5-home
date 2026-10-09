import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/store_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import '../../../../core/widgets/empty_state_view.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  void _openCart(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (ctx) => const CartScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final storeProvider = context.watch<StoreProvider>();
    final products = storeProvider.filteredProducts;
    final selectedCat = storeProvider.selectedCategory;
    final cartCount = storeProvider.totalItemCount;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storeTitle),
        actions: [
          Semantics(
            label: '${l10n.cartTitle}, $cartCount items',
            button: true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  tooltip: l10n.cartTitle,
                  onPressed: () => _openCart(context),
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchProducts,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              onChanged: (val) => storeProvider.setSearchQuery(val),
            ),
          ),
          // Category Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.categoryAll),
                  selected: selectedCat == null,
                  onSelected: (_) => storeProvider.setCategoryFilter(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.categoryNutrition),
                  selected: selectedCat == ProductCategory.nutrition,
                  onSelected: (_) => storeProvider.setCategoryFilter(ProductCategory.nutrition),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.categoryEquipment),
                  selected: selectedCat == ProductCategory.equipment,
                  onSelected: (_) => storeProvider.setCategoryFilter(ProductCategory.equipment),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.categoryApparel),
                  selected: selectedCat == ProductCategory.apparel,
                  onSelected: (_) => storeProvider.setCategoryFilter(ProductCategory.apparel),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Product Grid
          Expanded(
            child: products.isEmpty
                ? const EmptyStateView(
                    icon: Icons.storefront,
                    title: 'No products found',
                    message: 'Try selecting a different filter category.',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onAddToCart: () {
                          storeProvider.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} ${l10n.addedToCart}'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
