import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

class DescarteMenuScreen extends StatelessWidget {
  const DescarteMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Descarte de Defensivos',
      secao: SecaoTema.descarte,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuDescarte,
            titulo: 'Descarte responsável',
            subtitulo: 'Cuide do seu campo, das suas pessoas e do meio ambiente.',
            icone: Icons.recycling_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              children: [
                _Opcao(
                  icone: Icons.menu_book_rounded,
                  titulo: 'Como descartar',
                  subtitulo:
                      'Tríplice lavagem, perfuração e armazenamento correto',
                  onTap: () =>
                      Navigator.pushNamed(context, '/descarte/como'),
                ),
                const SizedBox(height: 12),
                _Opcao(
                  icone: Icons.location_on_rounded,
                  titulo: 'Onde descartar',
                  subtitulo: 'Centrais de coleta inPEV e revendas próximas',
                  onTap: () =>
                      Navigator.pushNamed(context, '/descarte/onde'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Opcao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;
  const _Opcao({
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.menuDescarte.withValues(alpha: .15),
            ],
          ),
          border: Border.all(
              color: AppColors.menuDescarte.withValues(alpha: .3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.menuDescarte.withValues(alpha: .15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.menuDescarte,
                        Color.lerp(
                            AppColors.menuDescarte, Colors.black, .25)!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icone, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                      const SizedBox(height: 4),
                      Text(subtitulo,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            height: 1.3,
                          )),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded,
                    color: AppColors.menuDescarte),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ComoDescartarScreen extends StatelessWidget {
  const ComoDescartarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Como Descartar',
      secao: SecaoTema.descarte,
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          SecaoHeader(
            cor: AppColors.menuDescarte,
            titulo: '4 passos do descarte',
            subtitulo: 'Procedimento exigido pela legislação brasileira.',
            icone: Icons.menu_book_rounded,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              children: [
                _Passo(
                  n: 1,
                  icone: Icons.water_drop_rounded,
                  titulo: 'Tríplice lavagem',
                  texto:
                      'Esvazie a embalagem no pulverizador. Adicione água até ¼ da capacidade, agite por 30s e despeje no tanque. Repita 3 vezes.',
                ),
                SizedBox(height: 10),
                _Passo(
                  n: 2,
                  icone: Icons.warning_amber_rounded,
                  titulo: 'Inutilização',
                  texto:
                      'Perfure o fundo da embalagem após a lavagem para impedir a reutilização indevida.',
                ),
                SizedBox(height: 10),
                _Passo(
                  n: 3,
                  icone: Icons.warehouse_rounded,
                  titulo: 'Armazenamento temporário',
                  texto:
                      'Guarde em local coberto, ventilado, longe de pessoas, animais e alimentos. Mantenha tampa e rótulo identificáveis.',
                ),
                SizedBox(height: 10),
                _Passo(
                  n: 4,
                  icone: Icons.local_shipping_rounded,
                  titulo: 'Devolução',
                  texto:
                      'Entregue em até 1 ano após a compra no posto de coleta indicado na nota fiscal — gratuitamente.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Passo extends StatelessWidget {
  final int n;
  final IconData icone;
  final String titulo, texto;
  const _Passo(
      {required this.n,
      required this.icone,
      required this.titulo,
      required this.texto});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.menuDescarte.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.menuDescarte.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.menuDescarte,
                      Color.lerp(AppColors.menuDescarte, Colors.black, .25)!,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icone, color: Colors.white, size: 22),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.menuDescarte, width: 1.5),
                  ),
                  child: Center(
                    child: Text('$n',
                        style: const TextStyle(
                          color: AppColors.menuDescarte,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(texto,
                    style: const TextStyle(
                        fontSize: 14, height: 1.4, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OndeDescartarScreen extends StatelessWidget {
  const OndeDescartarScreen({super.key});

  static const _locais = [
    _Local(
      nome: 'Central inPEV — Campo Grande/MS',
      endereco: 'Rod. BR-262, Km 13 · (67) 3000-0000',
      tipo: 'Posto Central',
      cor: AppColors.menuDescarte,
    ),
    _Local(
      nome: 'Central inPEV — Maringá/PR',
      endereco: 'Av. Industrial, 1500 · (44) 3000-0000',
      tipo: 'Posto Central',
      cor: AppColors.menuDescarte,
    ),
    _Local(
      nome: 'Coopagro — Cascavel/PR',
      endereco: 'Rod. PR-486, Km 5 · (45) 3000-0000',
      tipo: 'Recebedor credenciado',
      cor: Color(0xFF7B4FA8),
    ),
    _Local(
      nome: 'Agropecuária Estrela — Passo Fundo/RS',
      endereco: 'Av. Brasil, 4000 · (54) 3000-0000',
      tipo: 'Revenda',
      cor: Color(0xFF6F4F9C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Pontos de Descarte',
      secao: SecaoTema.descarte,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuDescarte,
            titulo: '${4} pontos próximos',
            subtitulo: 'Postos credenciados e revendas autorizadas.',
            icone: Icons.location_on_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
            child: Column(
              children: [
                for (final l in _locais) ...[
                  _CardLocal(local: l),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardLocal extends StatelessWidget {
  final _Local local;
  const _CardLocal({required this.local});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: local.cor.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: local.cor.withValues(alpha: .08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: local.cor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.place_rounded, color: local.cor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: local.cor.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(local.tipo,
                      style: TextStyle(
                        color: local.cor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .3,
                      )),
                ),
                const SizedBox(height: 6),
                Text(local.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    )),
                const SizedBox(height: 4),
                Text(local.endereco,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12.5,
                      height: 1.35,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Local {
  final String nome, endereco, tipo;
  final Color cor;
  const _Local({
    required this.nome,
    required this.endereco,
    required this.tipo,
    required this.cor,
  });
}
