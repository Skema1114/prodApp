import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Silhueta visual de silo (cone + cilindro) com preenchimento animado
/// e ícone do grão sobre a porção cheia.
class SiloShape extends StatelessWidget {
  final double pct;
  final Color cor;
  final String? grainAsset;
  final double width;
  final double height;

  const SiloShape({
    super.key,
    required this.pct,
    required this.cor,
    this.grainAsset,
    this.width = 70,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: _SiloPainter(pct: pct.clamp(0, 1), cor: cor),
          ),
          if (grainAsset != null)
            Positioned(
              bottom: height * 0.12 + (height * 0.55 * pct.clamp(0, 1)) / 2 - 14,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .92),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: cor.withValues(alpha: .3), blurRadius: 4),
                  ],
                ),
                child: Image.asset(
                  'assets/images/$grainAsset',
                  width: 22,
                  height: 22,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.grain_rounded, size: 22, color: cor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SiloPainter extends CustomPainter {
  final double pct;
  final Color cor;
  _SiloPainter({required this.pct, required this.cor});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final topConeH = h * 0.18;
    final bodyTop = topConeH;
    final bodyBottom = h * 0.94;
    final bodyH = bodyBottom - bodyTop;
    final bodyW = w * 0.78;
    final left = (w - bodyW) / 2;
    final right = left + bodyW;

    // Cone superior (telhado)
    final conePath = Path()
      ..moveTo(w / 2, 0)
      ..lineTo(right + 4, bodyTop)
      ..lineTo(left - 4, bodyTop)
      ..close();

    final paintCone = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          cor.withValues(alpha: .9),
          Color.lerp(cor, Colors.black, .25)!,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, bodyTop));
    canvas.drawPath(conePath, paintCone);

    // Corpo cilíndrico (fundo)
    final bodyRect = RRect.fromLTRBR(
        left, bodyTop, right, bodyBottom, const Radius.circular(6));
    final paintBody = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.cinzaSuave,
          Colors.white,
          AppColors.cinzaSuave,
        ],
        stops: const [0, .5, 1],
      ).createShader(bodyRect.outerRect);
    canvas.drawRRect(bodyRect, paintBody);

    // Borda externa
    final stroke = Paint()
      ..color = cor.withValues(alpha: .65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(bodyRect, stroke);

    // Fill (preenchimento) — cresce de baixo para cima
    final fillH = bodyH * pct;
    final fillRect = Rect.fromLTRB(
        left + 1.5, bodyBottom - fillH, right - 1.5, bodyBottom - 1);
    canvas.save();
    canvas.clipRRect(RRect.fromLTRBR(left + 1.5, bodyTop + 1.5,
        right - 1.5, bodyBottom - 1, const Radius.circular(4)));
    final paintFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          cor.withValues(alpha: .55),
          cor.withValues(alpha: .85),
        ],
      ).createShader(fillRect);
    canvas.drawRect(fillRect, paintFill);

    // Linha do nível (highlight)
    if (pct > 0.02) {
      final nivel = Paint()
        ..color = Colors.white.withValues(alpha: .6)
        ..strokeWidth = 1.2;
      canvas.drawLine(
        Offset(left + 2, bodyBottom - fillH),
        Offset(right - 2, bodyBottom - fillH),
        nivel,
      );
    }
    canvas.restore();

    // Linhas horizontais decorativas (gomos do silo)
    final linha = Paint()
      ..color = cor.withValues(alpha: .15)
      ..strokeWidth = 0.8;
    for (var i = 1; i < 4; i++) {
      final y = bodyTop + bodyH * (i / 4);
      canvas.drawLine(Offset(left + 1, y), Offset(right - 1, y), linha);
    }

    // Base
    final base = Paint()..color = Color.lerp(cor, Colors.black, .3)!;
    canvas.drawRect(
        Rect.fromLTWH(left - 3, bodyBottom, bodyW + 6, h * 0.04), base);
  }

  @override
  bool shouldRepaint(covariant _SiloPainter old) =>
      old.pct != pct || old.cor != cor;
}
