class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String senha;

  const Usuario({this.id, required this.nome, required this.email, required this.senha});

  Map<String, dynamic> toMap() => {
        if (id != null) 'id_usuario': id,
        'nome_usuario': nome,
        'email_usuario': email,
        'senha_usuario': senha,
      };

  factory Usuario.fromMap(Map<String, dynamic> m) => Usuario(
        id: m['id_usuario'] as int?,
        nome: m['nome_usuario'] as String,
        email: m['email_usuario'] as String,
        senha: m['senha_usuario'] as String,
      );

  Usuario copyWith({int? id, String? nome, String? email, String? senha}) =>
      Usuario(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        senha: senha ?? this.senha,
      );
}
