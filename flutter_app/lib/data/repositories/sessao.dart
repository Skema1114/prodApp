import 'package:shared_preferences/shared_preferences.dart';

/// Substitui SharedPreferences do Android original — persiste sessão atual.
class Sessao {
  static const _kUserId = 'auth.userId';
  static const _kEmail = 'auth.email';
  static const _kSalvar = 'auth.salvarCredenciais';

  Future<void> salvar(int userId, String email, {bool persistir = false}) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kUserId, userId);
    await p.setString(_kEmail, email);
    await p.setBool(_kSalvar, persistir);
  }

  Future<int?> userId() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kUserId);
  }

  Future<String?> email() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_kEmail);
  }

  Future<bool> deveSalvar() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kSalvar) ?? false;
  }

  Future<void> limpar() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_kUserId);
    await p.remove(_kEmail);
    await p.remove(_kSalvar);
  }
}
