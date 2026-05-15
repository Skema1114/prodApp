import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/sessao.dart';
import '../../data/repositories/usuario_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _salvar = false;
  bool _ocupado = false;
  bool _verSenha = false;
  final _repo = UsuarioRepository();

  @override
  void initState() {
    super.initState();
    _carregarSessao();
  }

  Future<void> _carregarSessao() async {
    final s = Sessao();
    if (await s.deveSalvar()) {
      _email.text = await s.email() ?? '';
      if (mounted) setState(() => _salvar = true);
    }
  }

  Future<void> _logar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _ocupado = true);
    try {
      final u = await _repo.autenticar(_email.text.trim(), _senha.text);
      if (!mounted) return;
      if (u == null) {
        _erro('E-mail ou senha inválidos.');
        return;
      }
      await Sessao().salvar(u.id!, u.email, persistir: _salvar);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/menu');
    } catch (e) {
      _erro('Falha ao autenticar: $e');
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  void _erro(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.vermelho,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.paraSecao(SecaoTema.central),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.menuCentral,
                    AppColors.menuCentral.withValues(alpha: .85),
                    AppColors.branco,
                  ],
                  stops: const [0, .35, .6],
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Image.asset('assets/images/logo.png',
                          height: 100,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.agriculture,
                              size: 80,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      const Text('ProdAPP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          )),
                      const SizedBox(height: 2),
                      const Text('Tecnologia para o campo',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          )),
                      const SizedBox(height: 28),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
                          child: Form(
                            key: _form,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Entrar',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    prefixIcon: Icon(Icons.email_outlined),
                                  ),
                                  validator: (v) =>
                                      (v == null || v.isEmpty)
                                          ? 'Você deve informar o e-mail!'
                                          : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _senha,
                                  obscureText: !_verSenha,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon: Icon(_verSenha
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () => setState(
                                          () => _verSenha = !_verSenha),
                                    ),
                                  ),
                                  validator: (v) =>
                                      (v == null || v.isEmpty)
                                          ? 'Você deve informar a senha!'
                                          : null,
                                ),
                                CheckboxListTile(
                                  value: _salvar,
                                  onChanged: (v) =>
                                      setState(() => _salvar = v ?? false),
                                  title: const Text('Manter conectado'),
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  dense: true,
                                ),
                                const SizedBox(height: 4),
                                FilledButton(
                                  onPressed: _ocupado ? null : _logar,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.menuCentral,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: _ocupado
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2))
                                      : const Text('Entrar',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/cadastro'),
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.preto),
                        child: const Text.rich(TextSpan(children: [
                          TextSpan(text: 'Não tem conta? '),
                          TextSpan(
                              text: 'Cadastre-se',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
