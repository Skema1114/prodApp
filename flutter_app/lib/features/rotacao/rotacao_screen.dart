import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';

class RotacaoCulturaScreen extends StatefulWidget {
  const RotacaoCulturaScreen({super.key});

  @override
  State<RotacaoCulturaScreen> createState() => _RotacaoCulturaScreenState();
}

class _RotacaoCulturaScreenState extends State<RotacaoCulturaScreen> {
  static const _opcoes = [
    'Arroz', 'Milho', 'Soja', 'Trigo',
    'Girassol', 'Milhete', 'Sorgo', 'Tremoço',
  ];
  final _selecionadas = <String>{};

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Rotação de Culturas',
      secao: SecaoTema.rotacao,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selecione as culturas que deseja considerar na rotação:',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _opcoes.map((c) {
              final sel = _selecionadas.contains(c);
              return FilterChip(
                label: Text(c),
                selected: sel,
                selectedColor: AppColors.menuRotacao.withValues(alpha: .25),
                checkmarkColor: AppColors.menuRotacao,
                onSelected: (v) => setState(() {
                  if (v) {
                    _selecionadas.add(c);
                  } else {
                    _selecionadas.remove(c);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _selecionadas.length < 2
                ? null
                : () => _gerarDiagrama(context),
            icon: const Icon(Icons.auto_graph),
            label: const Text('Criar diagrama'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.menuRotacao,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 24),
          if (_selecionadas.length >= 2)
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomPaint(
                    painter: _DiagramaRotacaoPainter(
                        _selecionadas.toList()),
                  ),
                ),
              ),
            ),
          if (_selecionadas.length >= 2) ...[
            const SizedBox(height: 12),
            const Text(
              'Sequência sugerida (sentido horário):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(_selecionadas.join(' → ')),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/rotacao/detalhes'),
              icon: const Icon(Icons.info_outline),
              label: const Text('Informações complementares'),
            ),
          ],
        ],
      ),
    );
  }

  void _gerarDiagrama(BuildContext context) {
    setState(() {});
  }
}

class _DiagramaRotacaoPainter extends CustomPainter {
  final List<String> itens;
  _DiagramaRotacaoPainter(this.itens);

  @override
  void paint(Canvas canvas, Size size) {
    final centro = Offset(size.width / 2, size.height / 2);
    final raio = math.min(size.width, size.height) / 2 - 40;
    final n = itens.length;

    final paintLinha = Paint()
      ..color = AppColors.menuRotacao
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintCirc = Paint()..color = AppColors.menuRotacao;

    final pontos = List.generate(n, (i) {
      final ang = -math.pi / 2 + (2 * math.pi * i / n);
      return Offset(
        centro.dx + raio * math.cos(ang),
        centro.dy + raio * math.sin(ang),
      );
    });

    for (var i = 0; i < n; i++) {
      final p1 = pontos[i];
      final p2 = pontos[(i + 1) % n];
      _desenharSeta(canvas, p1, p2, paintLinha);
    }

    for (var i = 0; i < n; i++) {
      final p = pontos[i];
      canvas.drawCircle(p, 26, paintCirc);
      final tp = TextPainter(
        text: TextSpan(
          text: itens[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 60);
      tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy - tp.height / 2));
    }
  }

  void _desenharSeta(Canvas canvas, Offset a, Offset b, Paint paint) {
    final dir = (b - a);
    final dist = dir.distance;
    if (dist == 0) return;
    final unit = dir / dist;
    final start = a + unit * 28;
    final end = b - unit * 28;
    canvas.drawLine(start, end, paint);
    final perp = Offset(-unit.dy, unit.dx);
    final p1 = end - unit * 10 + perp * 5;
    final p2 = end - unit * 10 - perp * 5;
    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.menuRotacao);
  }

  @override
  bool shouldRepaint(_) => true;
}

class RotacaoDetalhesScreen extends StatelessWidget {
  const RotacaoDetalhesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Informações Complementares',
      secao: SecaoTema.rotacao,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Por que rotacionar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'A rotação de culturas quebra o ciclo de pragas e doenças, melhora a estrutura do solo, '
            'aumenta a matéria orgânica e reduz a dependência de insumos.',
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
          SizedBox(height: 16),
          Text('Princípios básicos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            '• Alternar gramíneas (milho, sorgo) com leguminosas (soja, tremoço) para balancear nitrogênio.\n'
            '• Inserir plantas de cobertura (milhete, girassol) entre safras comerciais.\n'
            '• Evitar repetir a mesma cultura na mesma área por mais de 2 safras.\n'
            '• Considerar a aptidão do solo e o histórico de pragas locais.',
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }
}
