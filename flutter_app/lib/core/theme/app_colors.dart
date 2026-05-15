import 'package:flutter/material.dart';

/// Paleta extraída do ProdAPP original (res/values/colors.xml).
/// Cores semânticas por seção — cada módulo tem sua cor de identidade.
class AppColors {
  AppColors._();

  // Cores base
  static const primary = Color(0xFF3F51B5);
  static const primaryDark = Color(0xFF303F9F);
  static const accent = Color(0xFFFF4081);

  // Status / feedback
  static const verde = Color(0xFF11772D);
  static const amarelo = Color(0xFFF2F302);
  static const vermelho = Color(0xFFCC0000);
  static const padraoBotao = Color(0xFFD6D7D7);

  // Cores temáticas por seção (mantidas do original)
  static const menuCentral = Color(0xFF98CD65);
  static const menuSilo = Color(0xFF4A84E1);
  static const menuUsuario = Color(0xFFE4A943);
  static const menuNoticias = Color(0xFF99CC66);
  static const menuEpocas = Color(0xFFEA5E54);
  static const menuDescarte = Color(0xFFAA66CC);
  static const menuRotacao = Color(0xFFD45ED2);
  static const menuPraga = Color(0xFF53BCBE);
  static const menuWifi = Color(0xFFA883D4);

  // Neutros
  static const branco = Color(0xFFFAFAFA);
  static const preto = Color(0xFF080808);
  static const cinzaSuave = Color(0xFFEEEEEE);
}
