import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/cultura.dart';
import '../../shared/static_data/epocas_plantio.dart';
import '../../shared/widgets/cultura_card.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

class CalendarioPlantioScreen extends StatelessWidget {
  const CalendarioPlantioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Calendário de Plantio',
      secao: SecaoTema.epocas,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuEpocas,
            titulo: 'Janelas de plantio',
            subtitulo: 'Períodos ideais por cultura e região.',
            icone: Icons.calendar_month_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              children: [
                for (final c in Cultura.values) ...[
                  CulturaCard(
                    cultura: c,
                    subtitulo: epocaDe(c).janelaIdeal,
                    corSecao: AppColors.menuEpocas,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EpocaCulturaScreen(cultura: c)),
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

class EpocaCulturaScreen extends StatelessWidget {
  final Cultura cultura;
  const EpocaCulturaScreen({super.key, required this.cultura});

  @override
  Widget build(BuildContext context) {
    final e = epocaDe(cultura);
    return ScaffoldSecao(
      titulo: 'Plantio de ${cultura.nome}',
      secao: SecaoTema.epocas,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cultura.cor.withValues(alpha: .9),
                  Color.lerp(cultura.cor, Colors.black, .15)!,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: cultura.cor.withValues(alpha: .35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .15),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset('assets/images/${cultura.iconAsset}',
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.eco, color: cultura.cor, size: 56)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(cultura.nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                Text(e.janelaIdeal,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _Bloco(
                    icone: Icons.location_on_outlined,
                    titulo: 'Região indicada',
                    texto: e.regiao,
                    cor: AppColors.menuEpocas),
                _Bloco(
                    icone: Icons.terrain_rounded,
                    titulo: 'Solo recomendado',
                    texto: e.solo,
                    cor: AppColors.menuEpocas),
                _Bloco(
                    icone: Icons.tips_and_updates_rounded,
                    titulo: 'Observações técnicas',
                    texto: e.observacoes,
                    cor: AppColors.menuEpocas),
                const SizedBox(height: 20),
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
  final Color cor;
  const _Bloco({
    required this.icone,
    required this.titulo,
    required this.texto,
    required this.cor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cor.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: cor.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, color: cor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: cor,
                    )),
                const SizedBox(height: 4),
                Text(texto,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
