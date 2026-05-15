import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/usuario.dart';
import '../../data/repositories/usuario_repository.dart';
import '../../shared/widgets/scaffold_secao.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _emailConf = TextEditingController();
  final _senha = TextEditingController();
  final _senhaConf = TextEditingController();
  final _repo = UsuarioRepository();
  bool _ocupado = false;

  String? _validarObrig(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Esses campos são obrigatórios!' : null;

  Future<void> _cadastrar() async {
    if (!_form.currentState!.validate()) return;
    if (_email.text.trim() != _emailConf.text.trim()) {
      _msg('Os E-mails Informados São Diferentes!');
      return;
    }
    if (_senha.text != _senhaConf.text) {
      _msg('As Senhas Informadas São Diferentes!');
      return;
    }
    setState(() => _ocupado = true);
    try {
      await _repo.inserir(Usuario(
        nome: _nome.text.trim(),
        email: _email.text.trim(),
        senha: _senha.text,
      ));
      _msg('Registro cadastrado com sucesso!');
      if (mounted) Navigator.pop(context);
    } catch (_) {
      _msg('Erro ao salvar! E-mail já em uso?');
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  void _msg(String m) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Cadastro',
      secao: SecaoTema.central,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(labelText: 'Nome:'),
                validator: _validarObrig,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail:'),
                validator: _validarObrig,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailConf,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'Informe seu E-mail Novamente:'),
                validator: _validarObrig,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _senha,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha:'),
                validator: _validarObrig,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaConf,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Informe sua Senha Novamente:'),
                validator: _validarObrig,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _ocupado ? null : _cadastrar,
                child: _ocupado
                    ? const SizedBox(
                        height: 22, width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Cadastrar-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
