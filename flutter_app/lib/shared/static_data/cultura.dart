import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum Cultura {
  arroz('Arroz', 'iconearroz.png', Color(0xFFC9A66B)),
  milho('Milho', 'iconemilho.png', Color(0xFFE8A317)),
  soja('Soja', 'iconesoja.png', Color(0xFF8FAD3F)),
  trigo('Trigo', 'iconetrigo.png', Color(0xFFB68B43));

  final String nome;
  final String iconAsset;
  final Color cor;
  const Cultura(this.nome, this.iconAsset, this.cor);

  static Cultura? porNome(String n) {
    final s = n.toLowerCase().trim();
    for (final c in values) {
      if (c.nome.toLowerCase() == s) return c;
    }
    return null;
  }

  /// Asset do ícone para um produto. Fallback se desconhecido.
  static String iconParaProduto(String produto) {
    final c = porNome(produto);
    return c?.iconAsset ?? 'iconemilho.png';
  }

  static Color corParaProduto(String produto) {
    return porNome(produto)?.cor ?? AppColors.menuSilo;
  }
}
