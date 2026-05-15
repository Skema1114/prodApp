import 'package:flutter/material.dart';
import '../static_data/cultura.dart';

/// Card padronizado de seleção por cultura — usado em Pragas e Calendário.
/// Substitui o ListTile com chevron por um cartão visual com gradiente
/// na cor da cultura + ícone do grão.
class CulturaCard extends StatelessWidget {
  final Cultura cultura;
  final String subtitulo;
  final Color corSecao;
  final VoidCallback onTap;

  const CulturaCard({
    super.key,
    required this.cultura,
    required this.subtitulo,
    required this.corSecao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cor = cultura.cor;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              cor.withValues(alpha: .18),
            ],
          ),
          border: Border.all(color: cor.withValues(alpha: .35), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: cor.withValues(alpha: .18),
              blurRadius: 10,
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
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cor.withValues(alpha: .4)),
                    boxShadow: [
                      BoxShadow(
                        color: cor.withValues(alpha: .25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/${cultura.iconAsset}',
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.eco, color: cor, size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cultura.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const SizedBox(height: 2),
                      Text(subtitulo,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: corSecao.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.arrow_forward_rounded,
                      color: corSecao, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
