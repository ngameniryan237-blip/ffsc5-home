import 'package:flutter/material.dart';

enum ProductCategory {
  nutrition,
  equipment,
  apparel,
}

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final ProductCategory category;
  final double rating;
  final int reviewCount;
  final IconData icon;
  final Color accentColor;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.icon = Icons.shopping_bag_outlined,
    this.accentColor = const Color(0xFF10B981),
  });
}
