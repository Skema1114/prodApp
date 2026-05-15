import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'prodapp.db';
  static const _dbVersion = 1;

  DatabaseHelper._();
  static final instance = DatabaseHelper._();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dir = await getDatabasesPath();
    final path = p.join(dir, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_usuario TEXT NOT NULL,
        email_usuario TEXT NOT NULL UNIQUE,
        senha_usuario TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE silos (
        id_silo INTEGER PRIMARY KEY AUTOINCREMENT,
        id_usuario INTEGER NOT NULL,
        nome_silo TEXT NOT NULL,
        produto_silo TEXT NOT NULL,
        tamanho_silo REAL NOT NULL,
        quantidade_atual REAL NOT NULL DEFAULT 0,
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
      )
    ''');

    // Seed inicial — replica do app Android (UsuariosBD/SilosBD)
    await db.insert('usuarios', {
      'id_usuario': 1,
      'nome_usuario': 'ProdAPP',
      'email_usuario': 'prodapp@gmail.com',
      'senha_usuario': 'prodapp',
    });
    await db.insert('silos', {
      'id_silo': 1,
      'id_usuario': 1,
      'nome_silo': 'ProdaPP',
      'produto_silo': 'Trigo',
      'tamanho_silo': 25000,
      'quantidade_atual': 5000,
    });
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
