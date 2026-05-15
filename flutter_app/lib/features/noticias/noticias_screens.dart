import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/static_data/noticias.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Novidades',
      secao: SecaoTema.noticias,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuNoticias,
            titulo: 'Fornecedores parceiros',
            subtitulo: 'Lançamentos, programas e novidades do setor.',
            icone: Icons.newspaper_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
            child: Column(
              children: [
                for (final f in fornecedores) ...[
                  _CardFornecedor(
                    fornecedor: f,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              NoticiasFornecedorScreen(f: f)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardFornecedor extends StatelessWidget {
  final Fornecedor fornecedor;
  final VoidCallback onTap;
  const _CardFornecedor({required this.fornecedor, required this.onTap});

  Color get _cor {
    final hex = fornecedor.corHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final cor = _cor;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, cor.withValues(alpha: .12)],
          ),
          border: Border.all(color: cor.withValues(alpha: .35)),
          boxShadow: [
            BoxShadow(
              color: cor.withValues(alpha: .15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cor.withValues(alpha: .3)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                        'assets/images/${fornecedor.logoAsset}',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.business, size: 32, color: cor)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fornecedor.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: cor.withValues(alpha: .15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                                '${fornecedor.noticias.length} ${fornecedor.noticias.length == 1 ? "notícia" : "notícias"}',
                                style: TextStyle(
                                  color: cor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: cor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoticiasFornecedorScreen extends StatelessWidget {
  final Fornecedor f;
  const NoticiasFornecedorScreen({super.key, required this.f});

  Color get _cor {
    final hex = f.corHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final cor = _cor;
    return ScaffoldSecao(
      titulo: f.nome,
      secao: SecaoTema.noticias,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SecaoHeader(
            cor: cor,
            titulo: f.nome,
            subtitulo: '${f.noticias.length} publicações',
            icone: Icons.newspaper_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
            child: Column(
              children: [
                for (final n in f.noticias) ...[
                  _CardNoticia(noticia: n, cor: cor),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardNoticia extends StatelessWidget {
  final Noticia noticia;
  final Color cor;
  const _CardNoticia({required this.noticia, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: cor.withValues(alpha: .12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset('assets/images/${noticia.imagemAsset}',
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: cor.withValues(alpha: .25),
                        child: Icon(Icons.image,
                            size: 56, color: cor),
                      )),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('NOVO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5,
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noticia.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.3,
                    )),
                const SizedBox(height: 8),
                Text(noticia.resumo,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
