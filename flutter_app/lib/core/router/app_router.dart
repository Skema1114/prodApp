import 'package:flutter/material.dart';

import '../../features/auth/cadastro_screen.dart';
import '../../features/auth/lista_usuarios_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/calendario/calendario_screens.dart';
import '../../features/descarte/descarte_screens.dart';
import '../../features/faq/faq_screen.dart';
import '../../features/menu/menu_central_screen.dart';
import '../../features/noticias/noticias_screens.dart';
import '../../features/pragas/pragas_screens.dart';
import '../../features/rotacao/rotacao_screen.dart';
import '../../features/silos/cadastro_silo_screen.dart';
import '../../features/silos/lista_silos_screen.dart';
import '../../features/silos/silo_detalhe_screen.dart';
import '../../features/sync/sync_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _r(const LoginScreen(), settings);
      case '/cadastro':
        return _r(const CadastroScreen(), settings);
      case '/menu':
        return _r(const MenuCentralScreen(), settings);

      case '/silos':
        return _r(const ListaSilosScreen(), settings);
      case '/silos/cadastro':
        return _r(const CadastroSiloScreen(), settings);
      case '/silos/detalhe':
        final id = settings.arguments as int;
        return _r(SiloDetalheScreen(idSilo: id), settings);

      case '/pragas':
        return _r(const SubMenuPragasScreen(), settings);

      case '/epocas':
        return _r(const CalendarioPlantioScreen(), settings);

      case '/rotacao':
        return _r(const RotacaoCulturaScreen(), settings);
      case '/rotacao/detalhes':
        return _r(const RotacaoDetalhesScreen(), settings);

      case '/descarte':
        return _r(const DescarteMenuScreen(), settings);
      case '/descarte/como':
        return _r(const ComoDescartarScreen(), settings);
      case '/descarte/onde':
        return _r(const OndeDescartarScreen(), settings);

      case '/noticias':
        return _r(const NoticiasScreen(), settings);

      case '/sync':
        return _r(const SyncScreen(), settings);

      case '/faq':
        return _r(const FaqScreen(), settings);

      case '/usuarios':
        return _r(const ListaUsuariosScreen(), settings);

      default:
        return _r(
          Scaffold(
              body: Center(child: Text('Rota não encontrada: ${settings.name}'))),
          settings,
        );
    }
  }

  static PageRoute _r(Widget child, RouteSettings settings) =>
      MaterialPageRoute(builder: (_) => child, settings: settings);
}
