import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final void Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.cardColor;

    return Semantics(
      label: '${item.product.title}, Quantity: ${item.quantity}, Price: \$${item.totalPrice.toStringAsFixed(2)}',
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF334155)
                : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: item.product.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.product.icon, color: item.product.accentColor, size: 26),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)} each',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Adjuster
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF334155)
                    : const Color(0xFFF1F5F9),
              ),
              child: Row(
                children: [
                  Semantics(
                    button: true,
                    label: 'Decrease quantity of ${item.product.title}',
                    child: IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => onQuantityChanged(item.quantity - 1),
                    ),
                  ),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Semantics(
                    button: true,
                    label: 'Increase quantity of ${item.product.title}',
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => onQuantityChanged(item.quantity + 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Subtotal & Delete
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              color: Colors.red.withValues(alpha: 0.7),
              tooltip: 'Remove',
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
