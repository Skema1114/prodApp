import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/silo.dart';
import '../../data/repositories/sessao.dart';
import '../../data/repositories/silo_repository.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/skeleton.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/error_state.dart';

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
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: .82,
              ),
              itemCount: silos.length,
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
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .82,
      ),
      itemCount: 4,
      itemBuilder: (_, __) => const Skeleton(height: double.infinity),
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

  @override
  Widget build(BuildContext context) {
    final pct = silo.porcentagemOcupada;
    final cor = _corPorOcupacao(pct);
    return Hero(
      tag: 'silo-${silo.id}',
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                cor.withValues(alpha: .08),
              ],
            ),
            border: Border.all(color: cor.withValues(alpha: .25)),
            boxShadow: [
              BoxShadow(
                color: cor.withValues(alpha: .15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cor.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.grain_rounded, color: cor, size: 22),
                      ),
                      const Spacer(),
                      Text('${(pct * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: cor,
                            fontSize: 18,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(silo.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  Text(silo.produto,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      )),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 8,
                      backgroundColor: AppColors.cinzaSuave,
                      valueColor: AlwaysStoppedAnimation(cor),
                    ),
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
          ),
        ),
      ),
    );
  }
}
