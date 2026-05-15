import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/cultura.dart';
import '../../shared/static_data/pragas.dart';
import '../../shared/widgets/scaffold_secao.dart';

class SubMenuPragasScreen extends StatelessWidget {
  const SubMenuPragasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Dicionário de Pragas',
      secao: SecaoTema.praga,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: Cultura.values.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final c = Cultura.values[i];
          return Card(
            child: ListTile(
              leading: _IconeCultura(c: c),
              title: Text(c.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  Text('${pragasDe(c).length} pragas catalogadas'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PragasCulturaScreen(cultura: c)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IconeCultura extends StatelessWidget {
  final Cultura c;
  const _IconeCultura({required this.c});
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/${c.iconAsset}',
        width: 48, height: 48,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.eco, size: 36, color: AppColors.menuPraga));
  }
}

class PragasCulturaScreen extends StatelessWidget {
  final Cultura cultura;
  const PragasCulturaScreen({super.key, required this.cultura});

  @override
  Widget build(BuildContext context) {
    final lista = pragasDe(cultura);
    return ScaffoldSecao(
      titulo: 'Pragas do ${cultura.nome}',
      secao: SecaoTema.praga,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        itemBuilder: (_, i) {
          final p = lista[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PragaDetalheScreen(praga: p)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (p.imagem != null)
                    Image.asset('assets/images/${p.imagem}',
                        height: 160, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                            height: 160,
                            color: AppColors.menuPraga.withValues(alpha: .3),
                            child: const Icon(Icons.bug_report, size: 48))),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 6),
                        Text(p.descricao,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PragaDetalheScreen extends StatelessWidget {
  final Praga praga;
  const PragaDetalheScreen({super.key, required this.praga});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: praga.nome.split('(').first.trim(),
      secao: SecaoTema.praga,
      body: ListView(
        children: [
          if (praga.imagem != null)
            Image.asset('assets/images/${praga.imagem}',
                height: 240, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    height: 240,
                    color: AppColors.menuPraga.withValues(alpha: .3),
                    child: const Icon(Icons.bug_report, size: 64))),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(praga.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 16),
                _Secao(titulo: 'Descrição', texto: praga.descricao),
                const SizedBox(height: 16),
                _Secao(titulo: 'Manejo e controle', texto: praga.controle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  final String titulo, texto;
  const _Secao({required this.titulo, required this.texto});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.menuPraga,
            )),
        const SizedBox(height: 6),
        Text(texto,
            style: const TextStyle(fontSize: 15, height: 1.4)),
      ],
    );
  }
}
