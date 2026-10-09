import 'package:flutter/material.dart';
import '../../providers/analytics_provider.dart';

class WeeklyChartPainter extends CustomPainter {
  final List<DailyMetric> metrics;
  final Color primaryColor;
  final Color todayColor;
  final Color backgroundColor;

  const WeeklyChartPainter({
    required this.metrics,
    required this.primaryColor,
    required this.todayColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (metrics.isEmpty) return;

    final barCount = metrics.length;
    final totalSpacing = size.width * 0.3;
    final spacing = totalSpacing / (barCount + 1);
    final barWidth = (size.width - totalSpacing) / barCount;
    final maxBarHeight = size.height - 24; // room for label

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < barCount; i++) {
      final metric = metrics[i];
      final x = spacing + i * (barWidth + spacing);
      final barHeight = (metric.completionRate * maxBarHeight).clamp(4.0, maxBarHeight);
      final y = maxBarHeight - barHeight;

      // Background Track
      final bgRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, 0, barWidth, maxBarHeight),
        const Radius.circular(8),
      );
      final bgPaint = Paint()..color = backgroundColor;
      canvas.drawRRect(bgRect, bgPaint);

      // Filled Bar
      final fillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(8),
      );
      final fillPaint = Paint()
        ..color = metric.isToday ? todayColor : primaryColor.withValues(alpha: 0.85);
      canvas.drawRRect(fillRect, fillPaint);

      // Label below bar
      textPainter.text = TextSpan(
        text: metric.dayLabel,
        style: TextStyle(
          color: metric.isToday ? todayColor : Colors.grey,
          fontSize: 12,
          fontWeight: metric.isToday ? FontWeight.bold : FontWeight.normal,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, size.height - 18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant WeeklyChartPainter oldDelegate) {
    return oldDelegate.metrics != metrics ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.todayColor != todayColor;
  }
}
