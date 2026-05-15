import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/silo.dart';
import '../../data/repositories/silo_repository.dart';
import '../../shared/widgets/error_state.dart';
import '../../shared/widgets/scaffold_secao.dart';

class SiloDetalheScreen extends StatefulWidget {
  final int idSilo;
  const SiloDetalheScreen({super.key, required this.idSilo});

  @override
  State<SiloDetalheScreen> createState() => _SiloDetalheScreenState();
}

class _SiloDetalheScreenState extends State<SiloDetalheScreen> {
  final _repo = SiloRepository();
  Silo? _silo;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    try {
      final s = await _repo.buscarPorId(widget.idSilo);
      if (!mounted) return;
      setState(() {
        _silo = s;
        _erro = s == null ? 'Silo não encontrado.' : null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _erro = e.toString());
    }
  }

  Future<void> _alterarQuantidade(double delta) async {
    if (_silo == null) return;
    final novo = (_silo!.quantidadeAtual + delta).clamp(0, _silo!.tamanho);
    final atualizado = _silo!.copyWith(quantidadeAtual: novo.toDouble());
    await _repo.atualizar(atualizado);
    if (!mounted) return;
    setState(() => _silo = atualizado);
  }

  Future<void> _remover() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover silo?'),
        content: Text('"${_silo!.nome}" será excluído permanentemente.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          FilledButton.tonal(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.vermelho.withValues(alpha: .15),
                  foregroundColor: AppColors.vermelho),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remover')),
        ],
      ),
    );
    if (ok != true) return;
    await _repo.remover(widget.idSilo);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_erro != null) {
      return ScaffoldSecao(
        titulo: 'Erro',
        secao: SecaoTema.silo,
        body: ErrorState(mensagem: _erro!, onRetry: _carregar),
      );
    }
    if (_silo == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final pct = _silo!.porcentagemOcupada;
    final cor = pct >= .85
        ? AppColors.vermelho
        : pct >= .6
            ? Colors.orange.shade700
            : AppColors.menuSilo;

    return ScaffoldSecao(
      titulo: _silo!.nome,
      secao: SecaoTema.silo,
      actions: [
        IconButton(
          tooltip: 'Remover',
          icon: const Icon(Icons.delete_outline),
          onPressed: _remover,
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Hero(
            tag: 'silo-${_silo!.id}',
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      cor.withValues(alpha: .12),
                    ],
                  ),
                  border: Border.all(color: cor.withValues(alpha: .3)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: _GaugeOcupacao(pct: pct, cor: cor),
                    ),
                    const SizedBox(height: 6),
                    Text('${(pct * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: cor,
                        )),
                    Text('ocupado',
                        style: TextStyle(
                          color: cor.withValues(alpha: .9),
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                children: [
                  _InfoLinha(rotulo: 'Produto', valor: _silo!.produto),
                  const Divider(height: 0),
                  _InfoLinha(
                      rotulo: 'Capacidade',
                      valor: '${_silo!.tamanho.toStringAsFixed(0)} L'),
                  const Divider(height: 0),
                  _InfoLinha(
                      rotulo: 'Quantidade atual',
                      valor:
                          '${_silo!.quantidadeAtual.toStringAsFixed(0)} L'),
                  const Divider(height: 0),
                  _InfoLinha(
                      rotulo: 'Disponível',
                      valor:
                          '${(_silo!.tamanho - _silo!.quantidadeAtual).toStringAsFixed(0)} L'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Ajustar quantidade',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _BotaoQtd(
                      icon: Icons.remove,
                      label: '-100 L',
                      cor: AppColors.vermelho,
                      onTap: () => _alterarQuantidade(-100))),
              const SizedBox(width: 10),
              Expanded(
                  child: _BotaoQtd(
                      icon: Icons.add,
                      label: '+100 L',
                      cor: AppColors.verde,
                      onTap: () => _alterarQuantidade(100))),
              const SizedBox(width: 10),
              Expanded(
                  child: _BotaoQtd(
                      icon: Icons.add_circle_outline,
                      label: '+1000 L',
                      cor: AppColors.menuSilo,
                      onTap: () => _alterarQuantidade(1000))),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoLinha extends StatelessWidget {
  final String rotulo, valor;
  const _InfoLinha({required this.rotulo, required this.valor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rotulo,
              style: const TextStyle(fontSize: 15, color: Colors.black54)),
          Text(valor,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// Gauge semicircular — substitui o termômetro segmentado anterior.
class _GaugeOcupacao extends StatelessWidget {
  final double pct;
  final Color cor;
  const _GaugeOcupacao({required this.pct, required this.cor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GaugePainter(pct: pct, cor: cor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Icon(Icons.grain_rounded, size: 38, color: cor),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double pct;
  final Color cor;
  _GaugePainter({required this.pct, required this.cor});

  @override
  void paint(Canvas canvas, Size size) {
    final centro = Offset(size.width / 2, size.height * .85);
    final raio = math.min(size.width / 2, size.height) * .9;
    final rect = Rect.fromCircle(center: centro, radius: raio);

    final fundo = Paint()
      ..color = AppColors.cinzaSuave
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final preench = Paint()
      ..shader = SweepGradient(
        colors: [cor.withValues(alpha: .6), cor],
        startAngle: math.pi,
        endAngle: 2 * math.pi,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi, false, fundo);
    canvas.drawArc(rect, math.pi, math.pi * pct.clamp(0, 1), false, preench);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.pct != pct || old.cor != cor;
}

class _BotaoQtd extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color cor;
  final VoidCallback onTap;
  const _BotaoQtd(
      {required this.icon,
      required this.label,
      required this.cor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 2),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
