import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/usuario.dart';
import '../../data/repositories/usuario_repository.dart';
import '../../shared/widgets/error_state.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/skeleton.dart';

class ListaUsuariosScreen extends StatefulWidget {
  const ListaUsuariosScreen({super.key});

  @override
  State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
}

class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
  final _repo = UsuarioRepository();
  late Future<List<Usuario>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _repo.listar();
  }

  Future<void> _recarregar() async {
    setState(() => _futuro = _repo.listar());
    await _futuro;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Usuários',
      secao: SecaoTema.usuario,
      body: RefreshIndicator(
        onRefresh: _recarregar,
        color: AppColors.menuUsuario,
        child: FutureBuilder<List<Usuario>>(
          future: _futuro,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (_, __) => const Skeleton(height: 70),
              );
            }
            if (snap.hasError) {
              return ErrorState(
                mensagem: 'Não foi possível carregar os usuários.',
                detalhe: snap.error.toString(),
                onRetry: _recarregar,
              );
            }
            final usuarios = snap.data ?? const [];
            if (usuarios.isEmpty) {
              return const Center(child: Text('Nenhum usuário cadastrado.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: usuarios.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (_, i) {
                final u = usuarios[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.menuUsuario,
                      child: Text(
                        u.nome.isNotEmpty ? u.nome[0].toUpperCase() : '?',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(u.nome,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(u.email),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
