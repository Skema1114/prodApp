import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

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
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuRotacao,
            titulo: 'Planeje sua rotação',
            subtitulo: 'Selecione 2 ou mais culturas e gere o diagrama.',
            icone: Icons.rotate_right_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _opcoes.map((c) {
                    final sel = _selecionadas.contains(c);
                    return _ChipCultura(
                      label: c,
                      selecionado: sel,
                      onTap: () => setState(() {
                        if (sel) {
                          _selecionadas.remove(c);
                        } else {
                          _selecionadas.add(c);
                        }
                      }),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: _selecionadas.length < 2 ? null : () => setState(() {}),
                  icon: const Icon(Icons.auto_graph_rounded),
                  label: const Text('Gerar diagrama'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.menuRotacao,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_selecionadas.length >= 2) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.menuRotacao.withValues(alpha: .25)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.menuRotacao.withValues(alpha: .15),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomPaint(
                        painter: _DiagramaRotacaoPainter(
                            _selecionadas.toList()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                          AppColors.menuRotacao.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: AppColors.menuRotacao.withValues(alpha: .3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timeline_rounded,
                                color: AppColors.menuRotacao, size: 18),
                            const SizedBox(width: 6),
                            const Text('Sequência sugerida',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.menuRotacao,
                                )),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(_selecionadas.join('  →  '),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/rotacao/detalhes'),
                    icon: const Icon(Icons.info_outline_rounded),
                    label:
                        const Text('Informações complementares'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.menuRotacao,
                      side: BorderSide(
                          color:
                              AppColors.menuRotacao.withValues(alpha: .5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipCultura extends StatelessWidget {
  final String label;
  final bool selecionado;
  final VoidCallback onTap;
  const _ChipCultura(
      {required this.label,
      required this.selecionado,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            gradient: selecionado
                ? LinearGradient(
                    colors: [
                      AppColors.menuRotacao,
                      Color.lerp(
                          AppColors.menuRotacao, Colors.black, .2)!,
                    ],
                  )
                : null,
            color: selecionado ? null : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: selecionado
                  ? AppColors.menuRotacao
                  : AppColors.menuRotacao.withValues(alpha: .4),
            ),
            boxShadow: selecionado
                ? [
                    BoxShadow(
                      color:
                          AppColors.menuRotacao.withValues(alpha: .3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selecionado)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(Icons.check_rounded,
                      color: Colors.white, size: 16),
                ),
              Text(label,
                  style: TextStyle(
                    color: selecionado
                        ? Colors.white
                        : AppColors.menuRotacao,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiagramaRotacaoPainter extends CustomPainter {
  final List<String> itens;
  _DiagramaRotacaoPainter(this.itens);

  @override
  void paint(Canvas canvas, Size size) {
    final centro = Offset(size.width / 2, size.height / 2);
    final raio = math.min(size.width, size.height) / 2 - 44;
    final n = itens.length;

    final pontos = List.generate(n, (i) {
      final ang = -math.pi / 2 + (2 * math.pi * i / n);
      return Offset(
        centro.dx + raio * math.cos(ang),
        centro.dy + raio * math.sin(ang),
      );
    });

    final paintLinha = Paint()
      ..color = AppColors.menuRotacao.withValues(alpha: .7)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < n; i++) {
      _desenharSeta(canvas, pontos[i], pontos[(i + 1) % n], paintLinha);
    }

    for (var i = 0; i < n; i++) {
      final p = pontos[i];
      final shadow = Paint()
        ..color = AppColors.menuRotacao.withValues(alpha: .3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(p + const Offset(0, 3), 30, shadow);

      final glow = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.menuRotacao,
            Color.lerp(AppColors.menuRotacao, Colors.black, .25)!,
          ],
        ).createShader(Rect.fromCircle(center: p, radius: 30));
      canvas.drawCircle(p, 30, glow);

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
      )..layout(maxWidth: 64);
      tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy - tp.height / 2));
    }
  }

  void _desenharSeta(Canvas canvas, Offset a, Offset b, Paint paint) {
    final dir = (b - a);
    final dist = dir.distance;
    if (dist == 0) return;
    final unit = dir / dist;
    final start = a + unit * 32;
    final end = b - unit * 32;
    canvas.drawLine(start, end, paint);
    final perp = Offset(-unit.dy, unit.dx);
    final p1 = end - unit * 10 + perp * 5;
    final p2 = end - unit * 10 - perp * 5;
    final arrow = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(arrow, Paint()..color = AppColors.menuRotacao);
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
        padding: EdgeInsets.zero,
        children: const [
          SecaoHeader(
            cor: AppColors.menuRotacao,
            titulo: 'Por que rotacionar?',
            subtitulo: 'Benefícios técnicos e princípios de manejo.',
            icone: Icons.science_rounded,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Bloco(
                  icone: Icons.eco_rounded,
                  titulo: 'Benefícios',
                  texto:
                      'A rotação quebra o ciclo de pragas e doenças, melhora a estrutura do solo, '
                      'aumenta a matéria orgânica e reduz a dependência de insumos.',
                ),
                SizedBox(height: 12),
                _Bloco(
                  icone: Icons.rule_rounded,
                  titulo: 'Princípios básicos',
                  texto:
                      '• Alternar gramíneas (milho, sorgo) com leguminosas (soja, tremoço) para balancear nitrogênio.\n'
                      '• Inserir plantas de cobertura (milhete, girassol) entre safras comerciais.\n'
                      '• Evitar repetir a mesma cultura na mesma área por mais de 2 safras.\n'
                      '• Considerar a aptidão do solo e o histórico de pragas locais.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bloco extends StatelessWidget {
  final IconData icone;
  final String titulo, texto;
  const _Bloco(
      {required this.icone, required this.titulo, required this.texto});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.menuRotacao.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.menuRotacao.withValues(alpha: .08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.menuRotacao.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icone,
                    color: AppColors.menuRotacao, size: 22),
              ),
              const SizedBox(width: 10),
              Text(titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.menuRotacao,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Text(texto,
              style: const TextStyle(
                  fontSize: 14, height: 1.5, color: Colors.black87)),
        ],
      ),
    );
  }
}
