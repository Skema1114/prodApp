import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/repositories/sessao.dart';

class DrawerLateral extends StatelessWidget {
  const DrawerLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF81C784),
                  Color(0xFF4CAF50),
                  Color(0xFF2E7D32),
                ],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
            child: FutureBuilder<String?>(
              future: Sessao().email(),
              builder: (context, snap) {
                final email = snap.data ?? 'prodapp@gmail.com';
                final inicial =
                    email.isNotEmpty ? email[0].toUpperCase() : '?';
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Text(inicial,
                          style: const TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ProdAPP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 2),
                          Text(email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _item(context, Icons.home_rounded, 'Menu Central', '/menu'),
                _item(context, Icons.grain_rounded, 'Meus Silos', '/silos',
                    cor: AppColors.menuSilo),
                _item(context, Icons.bug_report_rounded, 'Pragas', '/pragas',
                    cor: AppColors.menuPraga),
                _item(context, Icons.calendar_month_rounded, 'Calendário',
                    '/epocas',
                    cor: AppColors.menuEpocas),
                _item(context, Icons.rotate_right_rounded, 'Rotação',
                    '/rotacao',
                    cor: AppColors.menuRotacao),
                _item(context, Icons.recycling_rounded, 'Descarte',
                    '/descarte',
                    cor: AppColors.menuDescarte),
                _item(context, Icons.newspaper_rounded, 'Notícias',
                    '/noticias',
                    cor: AppColors.menuNoticias),
                _item(context, Icons.cloud_sync_rounded, 'Sincronização',
                    '/sync',
                    cor: AppColors.menuWifi),
                _item(context, Icons.help_outline_rounded, 'Dúvidas', '/faq',
                    cor: AppColors.menuUsuario),
                const Divider(height: 24),
                ListTile(
                  leading: const Icon(Icons.logout_rounded,
                      color: AppColors.vermelho),
                  title: const Text('Sair',
                      style: TextStyle(color: AppColors.vermelho)),
                  onTap: () async {
                    await Sessao().limpar();
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login', (_) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, String route,
      {Color? cor}) {
    final atual = ModalRoute.of(context)?.settings.name == route;
    return ListTile(
      leading: Icon(icon, color: cor ?? AppColors.primary),
      title: Text(label,
          style: TextStyle(
            fontWeight: atual ? FontWeight.bold : FontWeight.normal,
          )),
      selected: atual,
      selectedTileColor: (cor ?? AppColors.primary).withValues(alpha: .08),
      onTap: () {
        Navigator.of(context).pop();
        if (!atual) Navigator.of(context).pushNamed(route);
      },
    );
  }
}
