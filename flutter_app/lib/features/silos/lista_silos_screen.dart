import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/silo.dart';
import '../../data/repositories/sessao.dart';
import '../../data/repositories/silo_repository.dart';
import '../../shared/static_data/cultura.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/error_state.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/silo_shape.dart';
import '../../shared/widgets/skeleton.dart';

class ListaSilosScreen extends StatefulWidget {
  const ListaSilosScreen({super.key});

  @override
  State<ListaSilosScreen> createState() => _ListaSilosScreenState();
}

class _ListaSilosScreenState extends State<ListaSilosScreen> {
  final _repo = SiloRepository();
  late Future<List<Silo>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _carregar();
  }

  Future<List<Silo>> _carregar() async {
    final uid = (await Sessao().userId()) ?? 1;
    return _repo.listarPorUsuario(uid);
  }

  Future<void> _recarregar() async {
    final novo = _carregar();
    setState(() => _futuro = novo);
    await novo;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Meus Silos',
      secao: SecaoTema.silo,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.menuSilo,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.pushNamed(context, '/silos/cadastro');
          _recarregar();
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo silo'),
      ),
      body: RefreshIndicator(
        onRefresh: _recarregar,
        color: AppColors.menuSilo,
        child: FutureBuilder<List<Silo>>(
          future: _futuro,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const _SkeletonGrid();
            }
            if (snap.hasError) {
              return ErrorState(
                mensagem: 'Não foi possível carregar os silos.',
                detalhe: snap.error.toString(),
                onRetry: _recarregar,
              );
            }
            final silos = snap.data ?? const [];
            if (silos.isEmpty) {
              return const EmptyState(
                icone: Icons.grain_rounded,
                titulo: 'Nenhum silo cadastrado',
                mensagem:
                    'Toque em "Novo silo" para começar a monitorar seu armazenamento.',
                cor: AppColors.menuSilo,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 96),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: silos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _CardSilo(
                silo: silos[i],
                onTap: () async {
                  await Navigator.pushNamed(context, '/silos/detalhe',
                      arguments: silos[i].id);
                  _recarregar();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SkeletonGrid extends StatelessWidget {
  const _SkeletonGrid();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => const Skeleton(height: 140),
    );
  }
}

class _CardSilo extends StatelessWidget {
  final Silo silo;
  final VoidCallback onTap;
  const _CardSilo({required this.silo, required this.onTap});

  Color _corPorOcupacao(double pct) {
    if (pct >= .85) return AppColors.vermelho;
    if (pct >= .6) return Colors.orange.shade700;
    return AppColors.menuSilo;
  }

  String _rotuloOcupacao(double pct) {
    if (pct >= .85) return 'Crítico';
    if (pct >= .6) return 'Atenção';
    if (pct >= .2) return 'Normal';
    return 'Baixo';
  }

  @override
  Widget build(BuildContext context) {
    final pct = silo.porcentagemOcupada;
    final cor = _corPorOcupacao(pct);
    final rotulo = _rotuloOcupacao(pct);
    final grainAsset = Cultura.iconParaProduto(silo.produto);

    return Hero(
      tag: 'silo-${silo.id}',
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                cor.withValues(alpha: .10),
              ],
            ),
            border: Border.all(color: cor.withValues(alpha: .25)),
            boxShadow: [
              BoxShadow(
                color: cor.withValues(alpha: .18),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SiloShape(
                    pct: pct,
                    cor: cor,
                    grainAsset: grainAsset,
                    width: 78,
                    height: 110,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(silo.nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )),
                            ),
                            _Chip(label: rotulo, cor: cor),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Image.asset('assets/images/$grainAsset',
                                width: 14,
                                height: 14,
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.eco, size: 14, color: cor)),
                            const SizedBox(width: 4),
                            Text(silo.produto,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${(pct * 100).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: cor,
                                  fontSize: 28,
                                  height: 1,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(' %',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: cor,
                                    fontSize: 14,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${silo.quantidadeAtual.toStringAsFixed(0)} / ${silo.tamanho.toStringAsFixed(0)} L',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color cor;
  const _Chip({required this.label, required this.cor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cor.withValues(alpha: .35)),
      ),
      child: Text(label,
          style: TextStyle(
            color: cor,
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: .3,
          )),
    );
  }
}
