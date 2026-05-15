import '../db/database_helper.dart';
import '../models/silo.dart';

class SiloRepository {
  Future<int> inserir(Silo s) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('silos', s.toMap());
  }

  Future<int> atualizar(Silo s) async {
    final db = await DatabaseHelper.instance.database;
    return db.update('silos', s.toMap(),
        where: 'id_silo = ?', whereArgs: [s.id]);
  }

  Future<int> remover(int id) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('silos', where: 'id_silo = ?', whereArgs: [id]);
  }

  Future<List<Silo>> listarPorUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db
        .query('silos', where: 'id_usuario = ?', whereArgs: [idUsuario]);
    return rows.map(Silo.fromMap).toList();
  }

  Future<Silo?> buscarPorId(int id) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db
        .query('silos', where: 'id_silo = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Silo.fromMap(rows.first);
  }
}
