import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/sessao.dart';
import '../../shared/widgets/drawer_lateral.dart';
import '../../shared/widgets/scaffold_secao.dart';

class MenuCentralScreen extends StatelessWidget {
  const MenuCentralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_Acao>[
      _Acao('Meus Silos', Icons.grain_rounded, AppColors.menuSilo, '/silos',
          'Monitore estoque'),
      _Acao('Pragas', Icons.bug_report_rounded, AppColors.menuPraga, '/pragas',
          'Dicionário técnico'),
      _Acao('Calendário', Icons.calendar_month_rounded, AppColors.menuEpocas,
          '/epocas', 'Janela de plantio'),
      _Acao('Rotação', Icons.rotate_right_rounded, AppColors.menuRotacao,
          '/rotacao', 'Sequência de culturas'),
      _Acao('Descarte', Icons.recycling_rounded, AppColors.menuDescarte,
          '/descarte', 'Defensivos'),
      _Acao('Notícias', Icons.newspaper_rounded, AppColors.menuNoticias,
          '/noticias', 'Fornecedores'),
      _Acao('Sincronizar', Icons.cloud_sync_rounded, AppColors.menuWifi,
          '/sync', 'Backup nuvem'),
      _Acao('Dúvidas', Icons.help_outline_rounded, AppColors.menuUsuario,
          '/faq', 'Perguntas frequentes'),
      _Acao('Usuários', Icons.people_alt_rounded, AppColors.menuUsuario,
          '/usuarios', 'Conta'),
    ];

    return ScaffoldSecao(
      titulo: 'ProdAPP',
      secao: SecaoTema.central,
      podeVoltar: false,
      drawer: const DrawerLateral(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _CabecalhoBoasVindas()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            sliver: SliverGrid.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) => _CartaoModulo(acao: items[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CabecalhoBoasVindas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.menuCentral,
            AppColors.menuCentral.withValues(alpha: .75),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: FutureBuilder<String?>(
        future: Sessao().email(),
        builder: (context, snap) {
          final email = snap.data ?? '';
          final nome = email.split('@').first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bom dia, produtor',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  )),
              const SizedBox(height: 4),
              Text(
                nome.isEmpty
                    ? 'Bem-vindo ao ProdAPP'
                    : 'Olá, ${_capitalize(nome)} 👋',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Escolha um módulo para começar.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          );
        },
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _CartaoModulo extends StatelessWidget {
  final _Acao acao;
  const _CartaoModulo({required this.acao});

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
              acao.cor,
              Color.lerp(acao.cor, Colors.black, .2)!,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: acao.cor.withValues(alpha: .35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.pushNamed(context, acao.rota),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(acao.icon, color: Colors.white, size: 26),
                ),
                const Spacer(),
                Text(acao.titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                const SizedBox(height: 2),
                Text(acao.subtitulo,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .85),
                      fontSize: 12,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Acao {
  final String titulo;
  final IconData icon;
  final Color cor;
  final String rota;
  final String subtitulo;
  _Acao(this.titulo, this.icon, this.cor, this.rota, this.subtitulo);
}
