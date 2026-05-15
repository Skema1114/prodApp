import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/cultura.dart';
import '../../shared/static_data/epocas_plantio.dart';
import '../../shared/widgets/scaffold_secao.dart';

class CalendarioPlantioScreen extends StatelessWidget {
  const CalendarioPlantioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Calendário de Plantio',
      secao: SecaoTema.epocas,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: Cultura.values.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final c = Cultura.values[i];
          final e = epocaDe(c);
          return Card(
            child: ListTile(
              leading: Image.asset('assets/images/${c.iconAsset}',
                  width: 44, height: 44,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.calendar_month, color: AppColors.menuEpocas)),
              title: Text('Plantio de ${c.nome}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(e.janelaIdeal),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => EpocaCulturaScreen(cultura: c)),
              ),
            ),
          );
        },
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
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Image.asset('assets/images/${cultura.iconAsset}',
                height: 120,
                errorBuilder: (_, __, ___) => const Icon(Icons.eco,
                    size: 96, color: AppColors.menuEpocas)),
          ),
          const SizedBox(height: 24),
          _Bloco(titulo: 'Janela ideal', texto: e.janelaIdeal),
          _Bloco(titulo: 'Região indicada', texto: e.regiao),
          _Bloco(titulo: 'Solo recomendado', texto: e.solo),
          _Bloco(titulo: 'Observações', texto: e.observacoes),
        ],
      ),
    );
  }
}

class _Bloco extends StatelessWidget {
  final String titulo, texto;
  const _Bloco({required this.titulo, required this.texto});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.menuEpocas,
              )),
          const SizedBox(height: 4),
          Text(texto,
              style: const TextStyle(fontSize: 15, height: 1.4)),
        ],
      ),
    );
  }
}
