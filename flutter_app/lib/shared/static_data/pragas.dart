import 'cultura.dart';

class Praga {
  final String nome;
  final String descricao;
  final String controle;
  final String? imagem;
  const Praga(
      {required this.nome,
      required this.descricao,
      required this.controle,
      this.imagem});
}

const _pragas = <Cultura, List<Praga>>{
  Cultura.arroz: [
    Praga(
      nome: 'Percevejo-do-grão (Oebalus poecilus)',
      descricao:
          'Inseto sugador que ataca panículas, provocando grãos manchados ("rajado") e queda de produtividade.',
      controle:
          'Monitorar com rede entomológica. Aplicar inseticida quando atingir 2 percevejos/m². Manejo integrado: eliminar plantas hospedeiras nas margens.',
      imagem: 'pragarroz1.jpg',
    ),
    Praga(
      nome: 'Bicheira-da-raiz (Oryzophagus oryzae)',
      descricao:
          'Larvas atacam raízes do arroz irrigado, causando amarelecimento e tombamento.',
      controle:
          'Drenagem temporária da lavoura, tratamento de sementes com inseticida sistêmico e rotação de cultura.',
      imagem: 'pragarroz2.jpg',
    ),
  ],
  Cultura.milho: [
    Praga(
      nome: 'Lagarta-do-cartucho (Spodoptera frugiperda)',
      descricao:
          'Principal praga do milho. Lagartas destroem o cartucho e podem causar perdas de até 60%.',
      controle:
          'Manejo integrado: inseticidas em V4–V8, milho Bt, Trichogramma sp. e Bacillus thuringiensis.',
      imagem: 'pragamilho1.jpg',
    ),
    Praga(
      nome: 'Cigarrinha-do-milho (Dalbulus maidis)',
      descricao:
          'Transmite enfezamento pálido/vermelho e o vírus da risca — doenças que reduzem drasticamente a produtividade.',
      controle:
          'Tratamento de sementes, monitoramento com armadilhas amarelas, eliminação de plantas tigueras.',
      imagem: 'pragamilho2.jpg',
    ),
  ],
  Cultura.soja: [
    Praga(
      nome: 'Percevejo-marrom (Euschistus heros)',
      descricao:
          'Suga grãos em formação reduzindo peso e germinação. Provoca o "retenção foliar".',
      controle:
          'Pano-de-batida (2 percevejos/pano em produção). Inseticidas registrados em rotação de mecanismos.',
      imagem: 'pragasoja1.jpg',
    ),
    Praga(
      nome: 'Lagarta-da-soja (Anticarsia gemmatalis)',
      descricao:
          'Desfolhador clássico — pode consumir todo o limbo foliar em infestações altas.',
      controle:
          'Baculovirus anticarsia (controle biológico), monitoramento por pano-de-batida, inseticidas seletivos.',
      imagem: 'pragasoja2.jpg',
    ),
  ],
  Cultura.trigo: [
    Praga(
      nome: 'Pulgão-da-espiga (Sitobion avenae)',
      descricao:
          'Suga seiva da espiga, reduz peso de grãos e transmite o BYDV (vírus do nanismo amarelo).',
      controle:
          'Monitoramento semanal; inseticida apenas com >10 pulgões/espiga. Preservar inimigos naturais (joaninhas).',
    ),
    Praga(
      nome: 'Lagarta-do-trigo (Pseudaletia sequax)',
      descricao:
          'Ataca folhas e espigas em estágio leitoso, principalmente em invernos amenos.',
      controle:
          'Inseticida em focos identificados. Evitar plantio próximo a pastagens de azevém.',
    ),
  ],
};

List<Praga> pragasDe(Cultura c) => _pragas[c] ?? const [];
