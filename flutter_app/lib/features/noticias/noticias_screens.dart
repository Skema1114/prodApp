import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/noticias.dart';
import '../../shared/widgets/scaffold_secao.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Novidades',
      secao: SecaoTema.noticias,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: fornecedores.length,
        itemBuilder: (_, i) {
          final f = fornecedores[i];
          return Card(
            child: ListTile(
              leading: Image.asset('assets/images/${f.logoAsset}',
                  width: 56, height: 56, fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.business, size: 40)),
              title: Text(f.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${f.noticias.length} notícias recentes'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NoticiasFornecedorScreen(f: f)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NoticiasFornecedorScreen extends StatelessWidget {
  final Fornecedor f;
  const NoticiasFornecedorScreen({super.key, required this.f});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: f.nome,
      secao: SecaoTema.noticias,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: f.noticias.length,
        itemBuilder: (_, i) {
          final n = f.noticias[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/${n.imagemAsset}',
                    height: 180, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                          height: 180,
                          color: AppColors.menuNoticias.withValues(alpha: .3),
                          child: const Icon(Icons.image, size: 56),
                        )),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.titulo,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(n.resumo,
                          style:
                              const TextStyle(fontSize: 14, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
