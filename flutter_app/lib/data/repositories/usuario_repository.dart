import '../db/database_helper.dart';
import '../models/usuario.dart';

class UsuarioRepository {
  Future<int> inserir(Usuario u) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('usuarios', u.toMap());
  }

  Future<int> atualizar(Usuario u) async {
    final db = await DatabaseHelper.instance.database;
    return db.update('usuarios', u.toMap(),
        where: 'id_usuario = ?', whereArgs: [u.id]);
  }

  Future<int> remover(int id) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('usuarios', where: 'id_usuario = ?', whereArgs: [id]);
  }

  Future<List<Usuario>> listar() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('usuarios');
    return rows.map(Usuario.fromMap).toList();
  }

  Future<Usuario?> buscarPorId(int id) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db
        .query('usuarios', where: 'id_usuario = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Usuario.fromMap(rows.first);
  }

  Future<Usuario?> autenticar(String email, String senha) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'usuarios',
      where: 'email_usuario = ? AND senha_usuario = ?',
      whereArgs: [email, senha],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Usuario.fromMap(rows.first);
  }
}
