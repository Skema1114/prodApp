import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Scaffold reutilizável: cada seção troca a cor do AppBar conforme [SecaoTema].
/// Equivalente aos `TemaMenu*` do styles.xml original.
class ScaffoldSecao extends StatelessWidget {
  final String titulo;
  final SecaoTema secao;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool podeVoltar;

  const ScaffoldSecao({
    super.key,
    required this.titulo,
    required this.secao,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.drawer,
    this.podeVoltar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.paraSecao(secao),
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          automaticallyImplyLeading: podeVoltar,
          actions: actions,
        ),
        drawer: drawer,
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
