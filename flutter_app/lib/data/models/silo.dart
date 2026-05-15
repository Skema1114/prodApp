class Silo {
  final int? id;
  final int idUsuario;
  final String nome;
  final String produto;
  final double tamanho;
  final double quantidadeAtual;

  const Silo({
    this.id,
    required this.idUsuario,
    required this.nome,
    required this.produto,
    required this.tamanho,
    this.quantidadeAtual = 0,
  });

  double get porcentagemOcupada =>
      tamanho == 0 ? 0 : (quantidadeAtual / tamanho).clamp(0, 1);

  Map<String, dynamic> toMap() => {
        if (id != null) 'id_silo': id,
        'id_usuario': idUsuario,
        'nome_silo': nome,
        'produto_silo': produto,
        'tamanho_silo': tamanho,
        'quantidade_atual': quantidadeAtual,
      };

  factory Silo.fromMap(Map<String, dynamic> m) => Silo(
        id: m['id_silo'] as int?,
        idUsuario: m['id_usuario'] as int,
        nome: m['nome_silo'] as String,
        produto: m['produto_silo'] as String,
        tamanho: (m['tamanho_silo'] as num).toDouble(),
        quantidadeAtual: (m['quantidade_atual'] as num?)?.toDouble() ?? 0,
      );

  Silo copyWith({
    int? id,
    int? idUsuario,
    String? nome,
    String? produto,
    double? tamanho,
    double? quantidadeAtual,
  }) =>
      Silo(
        id: id ?? this.id,
        idUsuario: idUsuario ?? this.idUsuario,
        nome: nome ?? this.nome,
        produto: produto ?? this.produto,
        tamanho: tamanho ?? this.tamanho,
        quantidadeAtual: quantidadeAtual ?? this.quantidadeAtual,
      );
}
