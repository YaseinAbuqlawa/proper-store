import 'package:flutter/widgets.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';

/// A [CustomPainter] that draws a diagonal line from top-left to
/// bottom-right. Used to visually mark out-of-stock variant circles.
class OosDiagonalPainter extends CustomPainter {
  final Color color;

  const OosDiagonalPainter({this.color = AppColors.errorRed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
