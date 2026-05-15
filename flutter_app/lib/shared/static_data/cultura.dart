enum Cultura {
  arroz('Arroz', 'iconearroz.png'),
  milho('Milho', 'iconemilho.png'),
  soja('Soja', 'iconesoja.png'),
  trigo('Trigo', 'iconetrigo.png');

  final String nome;
  final String iconAsset;
  const Cultura(this.nome, this.iconAsset);
}
