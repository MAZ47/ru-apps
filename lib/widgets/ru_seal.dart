import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders the official emblem exactly as specified:
/// a circular seal, thin royal-blue outer ring on white, an open book in
/// nested crimson/gold/royal-blue bands, with a white sunburst centered on
/// the inner blue page. Kept flat — no gradients or shadows on the mark
/// itself so it stays crisp wherever it appears (header, splash, drawer).
class RuSeal extends StatelessWidget {
  final double size;

  const RuSeal({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _SealPainter()),
    );
  }
}

class _SealPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // White base disc
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFFFFFFF));

    // Thin royal-blue outer ring
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..color = const Color(0xFF1E4B9C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.06,
    );

    // Open book — outer crimson band
    final bookRect = Rect.fromCenter(center: center, width: radius * 1.5, height: radius * 1.3);
    _drawOpenBook(canvas, bookRect, const Color(0xFFD32F2F));

    // Middle gold band (inset)
    final goldRect = bookRect.deflate(radius * 0.16);
    _drawOpenBook(canvas, goldRect, const Color(0xFFF2B705));

    // Inner royal-blue pages (further inset)
    final blueRect = goldRect.deflate(radius * 0.14);
    _drawOpenBook(canvas, blueRect, const Color(0xFF1E4B9C));

    // White sunburst / flower centered on the blue pages
    _drawSunburst(canvas, center, blueRect.width * 0.28);
  }

  void _drawOpenBook(Canvas canvas, Rect rect, Color color) {
    final paint = Paint()..color = color;
    final path = Path();
    final mid = rect.center.dx;
    // Left page
    path.moveTo(mid, rect.top);
    path.quadraticBezierTo(rect.left, rect.top, rect.left, rect.center.dy);
    path.quadraticBezierTo(rect.left, rect.bottom, mid, rect.bottom);
    path.close();
    // Right page
    path.moveTo(mid, rect.top);
    path.quadraticBezierTo(rect.right, rect.top, rect.right, rect.center.dy);
    path.quadraticBezierTo(rect.right, rect.bottom, mid, rect.bottom);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSunburst(Canvas canvas, Offset center, double radius) {
    final paint = Paint()..color = const Color(0xFFFFFFFF);
    const points = 12;
    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi * 2) / (points * 2);
      final r = i.isEven ? radius : radius * 0.42;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




