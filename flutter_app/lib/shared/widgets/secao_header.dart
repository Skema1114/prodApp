import 'package:flutter/material.dart';

/// Header padronizado de seção — gradient na cor temática + título + ícone.
/// Usado no topo de listas para dar contexto visual ao módulo.
class SecaoHeader extends StatelessWidget {
  final Color cor;
  final String titulo;
  final String subtitulo;
  final IconData icone;

  const SecaoHeader({
    super.key,
    required this.cor,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cor.withValues(alpha: .85),
            cor,
            Color.lerp(cor, Colors.black, .15)!,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: cor.withValues(alpha: .35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .22),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icone, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .2,
                    )),
                const SizedBox(height: 2),
                Text(subtitulo,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .9),
                      fontSize: 13,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
