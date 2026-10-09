import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class StoreProvider extends ChangeNotifier {
  List<Product> _products = [];
  final Map<String, CartItem> _cartItems = {};
  ProductCategory? _selectedCategory;
  String _searchQuery = '';
  String? _appliedPromoCode;
  double _discountMultiplier = 0.0;

  StoreProvider() {
    _initProducts();
  }

  List<Product> get products => List.unmodifiable(_products);
  Map<String, CartItem> get cartItems => Map.unmodifiable(_cartItems);
  ProductCategory? get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String? get appliedPromoCode => _appliedPromoCode;
  double get discountPercent => _discountMultiplier * 100;

  List<Product> get filteredProducts {
    return _products.where((p) {
      final matchesCat = _selectedCategory == null || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();
  }

  int get totalItemCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return _cartItems.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get discountAmount {
    return subtotal * _discountMultiplier;
  }

  double get taxAmount {
    return (subtotal - discountAmount) * 0.05; // 5% tax
  }

  double get totalAmount {
    final net = (subtotal - discountAmount) + taxAmount;
    return net > 0 ? net : 0.0;
  }

  void setCategoryFilter(ProductCategory? cat) {
    if (_selectedCategory == cat) {
      _selectedCategory = null;
    } else {
      _selectedCategory = cat;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id] = _cartItems[product.id]!.copyWith(
        quantity: _cartItems[product.id]!.quantity + 1,
      );
    } else {
      _cartItems[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (!_cartItems.containsKey(productId)) return;
    if (newQuantity <= 0) {
      _cartItems.remove(productId);
    } else {
      _cartItems[productId] = _cartItems[productId]!.copyWith(quantity: newQuantity);
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  bool applyPromoCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'ZENITH20') {
      _appliedPromoCode = 'ZENITH20';
      _discountMultiplier = 0.20;
      notifyListeners();
      return true;
    } else if (cleanCode == 'WELCOME10') {
      _appliedPromoCode = 'WELCOME10';
      _discountMultiplier = 0.10;
      notifyListeners();
      return true;
    }
    return false;
  }

  void clearPromoCode() {
    _appliedPromoCode = null;
    _discountMultiplier = 0.0;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _appliedPromoCode = null;
    _discountMultiplier = 0.0;
    notifyListeners();
  }

  void _initProducts() {
    _products = [
      const Product(
        id: 'p1',
        title: 'Zenith Organic Whey Isolate',
        description: 'Ultra-pure grass-fed cold-filtered protein with BCAA & digestive enzymes.',
        price: 49.99,
        category: ProductCategory.nutrition,
        rating: 4.9,
        reviewCount: 342,
        icon: Icons.local_drink_outlined,
        accentColor: Color(0xFF10B981),
      ),
      const Product(
        id: 'p2',
        title: 'Pro Speed Resistance Bands Set',
        description: '5 levels of latex resistance tubes with door anchor, handles, and carry bag.',
        price: 29.95,
        category: ProductCategory.equipment,
        rating: 4.8,
        reviewCount: 218,
        icon: Icons.fitness_center,
        accentColor: Color(0xFF6366F1),
      ),
      const Product(
        id: 'p3',
        title: 'Smart Vacuum Insulated Flask (1L)',
        description: 'Triple-wall stainless steel bottle with digital temperature display lid.',
        price: 34.50,
        category: ProductCategory.equipment,
        rating: 4.7,
        reviewCount: 156,
        icon: Icons.water_drop_outlined,
        accentColor: Color(0xFF06B6D4),
      ),
      const Product(
        id: 'p4',
        title: 'Zenith Performance Breathable Tee',
        description: 'Ultra-light moisture-wicking anti-odor athletic shirt with 4-way stretch.',
        price: 38.00,
        category: ProductCategory.apparel,
        rating: 4.6,
        reviewCount: 94,
        icon: Icons.checkroom_outlined,
        accentColor: Color(0xFFF59E0B),
      ),
      const Product(
        id: 'p5',
        title: 'Daily Micronutrient & Electrolytes Pack',
        description: 'Complete multivitamin with minerals, magnesium, and hydration blend.',
        price: 24.99,
        category: ProductCategory.nutrition,
        rating: 4.9,
        reviewCount: 512,
        icon: Icons.medication_outlined,
        accentColor: Color(0xFF8B5CF6),
      ),
    ];
  }
}
