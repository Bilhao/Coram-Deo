import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Ícone oficial e canônico representativo do Opus Dei:
/// Um círculo que representa o mundo e, em seu interior, a Cruz de Cristo
/// que abraça todos os quadrantes da terra (desenhado por São Josemaria Escrivá em 1943).
class OpusDeiIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const OpusDeiIcon({super.key, this.size = 16.0, this.color});

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final effectiveColor =
        color ??
        iconTheme.color ??
        Theme.of(context).colorScheme.onSurfaceVariant;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _OpusDeiSealPainter(color: effectiveColor),
      ),
    );
  }
}

class _OpusDeiSealPainter extends CustomPainter {
  final Color color;

  _OpusDeiSealPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = math.max(1.0, size.width * 0.08);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    if (radius <= 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final clipPath = Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: radius + (strokeWidth / 2)),
      );

    canvas.save();
    canvas.clipPath(clipPath);

    // 1. Círculo exterior (O Mundo)
    canvas.drawCircle(center, radius, paint);

    // 2. Cruz inscrita (A Cruz abraçando o mundo)
    // Haste vertical
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );

    // Travessão horizontal
    canvas.drawLine(
      Offset(center.dx - radius, center.dy - 4),
      Offset(center.dx + radius, center.dy - 4),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OpusDeiSealPainter oldDelegate) =>
      oldDelegate.color != color;
}
