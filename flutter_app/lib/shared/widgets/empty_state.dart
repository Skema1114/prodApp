import 'package:flutter/material.dart';

/// Estado vazio padronizado: ícone circular + título + mensagem + ação opcional.
class EmptyState extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String mensagem;
  final Color cor;
  final Widget? acao;

  const EmptyState({
    super.key,
    required this.icone,
    required this.titulo,
    required this.mensagem,
    required this.cor,
    this.acao,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cor.withValues(alpha: .12),
              ),
              child: Icon(icone, size: 64, color: cor),
            ),
            const SizedBox(height: 20),
            Text(titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(height: 6),
            Text(mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 14)),
            if (acao != null) ...[
              const SizedBox(height: 20),
              acao!,
            ],
          ],
        ),
      ),
    );
  }
}
