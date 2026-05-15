import 'package:flutter/material.dart';

/// Cartão clicável com ícone + label — usado no MenuCentral.
class CartaoAcao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Color cor;
  final VoidCallback onTap;

  const CartaoAcao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cor,
      elevation: 3,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 44, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
