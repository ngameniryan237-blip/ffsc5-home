import 'dart:math';
import 'package:flutter/material.dart';

class ActivityRingPainter extends CustomPainter {
  final double moveProgress; // 0.0 to 1.0 (Calories)
  final double exerciseProgress; // 0.0 to 1.0 (Minutes)
  final double waterProgress; // 0.0 to 1.0 (Hydration)
  final Color moveColor;
  final Color exerciseColor;
  final Color waterColor;
  final Color trackColor;

  const ActivityRingPainter({
    required this.moveProgress,
    required this.exerciseProgress,
    required this.waterProgress,
    this.moveColor = const Color(0xFFF43F5E),
    this.exerciseColor = const Color(0xFF10B981),
    this.waterColor = const Color(0xFF06B6D4),
    this.trackColor = const Color(0xFF1E293B),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.08;
    final gap = strokeWidth + 4.0;

    // Outer Ring: Move (Calories)
    final r1 = (size.width / 2) - strokeWidth / 2;
    _drawRing(canvas, center, r1, strokeWidth, moveProgress, moveColor);

    // Middle Ring: Exercise (Minutes)
    final r2 = r1 - gap;
    _drawRing(canvas, center, r2, strokeWidth, exerciseProgress, exerciseColor);

    // Inner Ring: Hydration (Water)
    final r3 = r2 - gap;
    _drawRing(canvas, center, r3, strokeWidth, waterProgress, waterColor);
  }

  void _drawRing(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    double progress,
    Color color,
  ) {
    if (radius <= 0) return;

    final trackPaint = Paint()
      ..color = trackColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background track
    canvas.drawCircle(center, radius, trackPaint);

    // Draw filled arc
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
    if (sweepAngle > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ActivityRingPainter oldDelegate) {
    return oldDelegate.moveProgress != moveProgress ||
        oldDelegate.exerciseProgress != exerciseProgress ||
        oldDelegate.waterProgress != waterProgress ||
        oldDelegate.trackColor != trackColor;
  }
}
