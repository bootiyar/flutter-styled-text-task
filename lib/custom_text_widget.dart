import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;

  const CustomTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(size: Size(constraints.maxWidth, constraints.maxHeight), painter: _TextPainter(text));
      },
    );
  }
}

class _TextPainter extends CustomPainter {
  final String text;

  _TextPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    if (text.isEmpty) return;

    const textDirection = TextDirection.rtl;
    const padding = 16.0;
    const fontSize = 38.0;
    final center = Offset(size.width / 2, size.height / 2);

    Offset offset(TextPainter p) {
      return Offset(center.dx - p.width / 2, center.dy - p.height / 2);
    }

    /// ---------- Text in back ----------
    final textInBack = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          foreground: Paint()
            ..color = const Color(0xFF2EC4D6)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: textDirection,
    )..layout(maxWidth: size.width);

    /// ---------- Main Text ----------
    final mainText = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          shadows: [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(-3, 4))],
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: textDirection,
    )..layout(maxWidth: size.width);

    /// ---------- Background ----------
    final backgroundRect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: mainText.width + padding * 2, height: mainText.height + padding * 2);
    final backgroundPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    final rRectBackground = RRect.fromRectAndRadius(backgroundRect, const Radius.circular(24));

    /// ---------- Shadow  ----------
    canvas.drawShadow(Path()..addRRect(rRectBackground), Colors.black.withValues(alpha: 0.9), 12, false);

    /// ---------- Paint  ----------
    canvas.drawRRect(rRectBackground, backgroundPaint);
    textInBack.paint(canvas, offset(textInBack));
    mainText.paint(canvas, offset(mainText));
  }

  @override
  bool shouldRepaint(covariant _TextPainter oldDelegate) => oldDelegate.text != text;
}
