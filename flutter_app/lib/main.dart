import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/db/database_helper.dart';
import 'data/repositories/sessao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DatabaseHelper.instance.database;
  runApp(const ProdApp());
}

class ProdApp extends StatelessWidget {
  const ProdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProdAPP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.base(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const _RotaInicial(),
    );
  }
}

class _RotaInicial extends StatefulWidget {
  const _RotaInicial();

  @override
  State<_RotaInicial> createState() => _RotaInicialState();
}

class _RotaInicialState extends State<_RotaInicial> {
  @override
  void initState() {
    super.initState();
    _decidir();
  }

  Future<void> _decidir() async {
    final s = Sessao();
    final uid = await s.userId();
    final salvar = await s.deveSalvar();
    if (!mounted) return;
    final rota = (uid != null && salvar) ? '/menu' : '/login';
    Navigator.of(context).pushReplacementNamed(rota);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
