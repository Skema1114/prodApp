import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/cultura.dart';
import '../../shared/static_data/pragas.dart';
import '../../shared/widgets/cultura_card.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

class SubMenuPragasScreen extends StatelessWidget {
  const SubMenuPragasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Dicionário de Pragas',
      secao: SecaoTema.praga,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuPraga,
            titulo: 'Pragas por cultura',
            subtitulo: 'Identifique ameaças e veja recomendações de manejo.',
            icone: Icons.bug_report_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              children: [
                for (final c in Cultura.values) ...[
                  CulturaCard(
                    cultura: c,
                    subtitulo: '${pragasDe(c).length} pragas catalogadas',
                    corSecao: AppColors.menuPraga,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PragasCulturaScreen(cultura: c)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PragasCulturaScreen extends StatelessWidget {
  final Cultura cultura;
  const PragasCulturaScreen({super.key, required this.cultura});

  @override
  Widget build(BuildContext context) {
    final lista = pragasDe(cultura);
    return ScaffoldSecao(
      titulo: 'Pragas do ${cultura.nome}',
      secao: SecaoTema.praga,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SecaoHeader(
            cor: AppColors.menuPraga,
            titulo: '${cultura.nome} — ${lista.length} pragas',
            subtitulo: 'Toque em uma praga para ver manejo recomendado.',
            icone: Icons.bug_report_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
            child: Column(
              children: [
                for (var i = 0; i < lista.length; i++) ...[
                  _PragaCard(
                    praga: lista[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              PragaDetalheScreen(praga: lista[i])),
                    ),
                  ),
                  if (i < lista.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PragaCard extends StatelessWidget {
  final Praga praga;
  final VoidCallback onTap;
  const _PragaCard({required this.praga, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.menuPraga.withValues(alpha: .25)),
          boxShadow: [
            BoxShadow(
              color: AppColors.menuPraga.withValues(alpha: .12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    if (praga.imagem != null)
                      Image.asset('assets/images/${praga.imagem}',
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                              height: 170,
                              color: AppColors.menuPraga.withValues(alpha: .3),
                              child: const Icon(Icons.bug_report,
                                  size: 56, color: Colors.white))),
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.amber, size: 14),
                            SizedBox(width: 4),
                            Text('PRAGA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(praga.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                      const SizedBox(height: 6),
                      Text(praga.descricao,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            height: 1.35,
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Ver manejo',
                              style: TextStyle(
                                color: AppColors.menuPraga,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              )),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded,
                              color: AppColors.menuPraga, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PragaDetalheScreen extends StatelessWidget {
  final Praga praga;
  const PragaDetalheScreen({super.key, required this.praga});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: praga.nome.split('(').first.trim(),
      secao: SecaoTema.praga,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (praga.imagem != null)
            Stack(
              children: [
                Image.asset('assets/images/${praga.imagem}',
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        height: 260,
                        color: AppColors.menuPraga.withValues(alpha: .3),
                        child: const Icon(Icons.bug_report,
                            size: 64, color: Colors.white))),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: .65),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 16,
                  child: Text(praga.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black54,
                              blurRadius: 8,
                              offset: Offset(0, 2)),
                        ],
                      )),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Secao(
                    titulo: 'Descrição',
                    texto: praga.descricao,
                    icone: Icons.info_outline_rounded),
                const SizedBox(height: 14),
                _Secao(
                    titulo: 'Manejo e controle',
                    texto: praga.controle,
                    icone: Icons.shield_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  final String titulo, texto;
  final IconData icone;
  const _Secao(
      {required this.titulo, required this.texto, required this.icone});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.menuPraga.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.menuPraga.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.menuPraga.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icone, color: AppColors.menuPraga, size: 20),
              ),
              const SizedBox(width: 10),
              Text(titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.menuPraga,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Text(texto,
              style: const TextStyle(
                  fontSize: 15, height: 1.45, color: Colors.black87)),
        ],
      ),
    );
  }
}
