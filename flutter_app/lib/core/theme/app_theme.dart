import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Cada seção do ProdAPP tem sua identidade cromática.
/// Reproduz os temas `TemaMenu*` do styles.xml original em Flutter.
enum SecaoTema {
  central(AppColors.menuCentral, 'Central'),
  silo(AppColors.menuSilo, 'Silos'),
  usuario(AppColors.menuUsuario, 'Usuário'),
  noticias(AppColors.menuNoticias, 'Notícias'),
  epocas(AppColors.menuEpocas, 'Calendário'),
  descarte(AppColors.menuDescarte, 'Descarte'),
  rotacao(AppColors.menuRotacao, 'Rotação'),
  praga(AppColors.menuPraga, 'Pragas'),
  wifi(AppColors.menuWifi, 'Sincronização'),
  sobre(AppColors.menuUsuario, 'Sobre');

  final Color cor;
  final String label;
  const SecaoTema(this.cor, this.label);
}

class AppTheme {
  AppTheme._();

  static ThemeData base() => _build(AppColors.primary);

  static ThemeData paraSecao(SecaoTema secao) => _build(secao.cor);

  static ThemeData _build(Color primaria) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaria,
      primary: primaria,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.branco,
      appBarTheme: AppBarTheme(
        backgroundColor: primaria,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.padraoBotao,
          foregroundColor: AppColors.preto,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
