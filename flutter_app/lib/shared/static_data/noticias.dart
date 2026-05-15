class Fornecedor {
  final String nome;
  final String logoAsset;
  final String corHex;
  final List<Noticia> noticias;
  const Fornecedor({
    required this.nome,
    required this.logoAsset,
    required this.corHex,
    required this.noticias,
  });
}

class Noticia {
  final String titulo;
  final String resumo;
  final String imagemAsset;
  const Noticia(
      {required this.titulo, required this.resumo, required this.imagemAsset});
}

const fornecedores = <Fornecedor>[
  Fornecedor(
    nome: 'Agroeste',
    logoAsset: 'agroeste.png',
    corHex: '#0A6B45',
    noticias: [
      Noticia(
        titulo: 'Lançamento de híbrido AS 1633 PRO4',
        resumo:
            'Novo híbrido com tecnologia PRO4 oferece proteção contra principais lepidópteros e estabilidade produtiva em ambientes desafiadores.',
        imagemAsset: 'imagem1noticiaagroeste.jpg',
      ),
      Noticia(
        titulo: 'Programa de relacionamento com produtores',
        resumo:
            'Agroeste expande rede de dias de campo e capacitação técnica em todas as regiões produtoras.',
        imagemAsset: 'imagem2noticiaagroeste.jpg',
      ),
    ],
  ),
  Fornecedor(
    nome: 'Dekalb',
    logoAsset: 'dekalb.png',
    corHex: '#FFB300',
    noticias: [
      Noticia(
        titulo: 'DKB 290 PRO3 estréia na safrinha 2026',
        resumo:
            'Híbrido de ciclo precoce, alta sanidade e foco em janelas curtas de plantio.',
        imagemAsset: 'imagem1noticiadeklab.jpg',
      ),
    ],
  ),
  Fornecedor(
    nome: 'Dimicron',
    logoAsset: 'dimicron.png',
    corHex: '#1B5E20',
    noticias: [
      Noticia(
        titulo: 'Nova formulação foliar Boro+Cálcio',
        resumo:
            'Linha exclusiva para suprimento nas fases críticas da soja e do milho.',
        imagemAsset: 'imagem1noticiadimicron.jpg',
      ),
    ],
  ),
  Fornecedor(
    nome: 'Sementes Estrela',
    logoAsset: 'sementesestrela.png',
    corHex: '#C62828',
    noticias: [
      Noticia(
        titulo: 'Trigo BRS Reponte: vigor para o Sul',
        resumo:
            'Cultivar de alta qualidade industrial e tolerância à brusone, adaptada ao Sul do Brasil.',
        imagemAsset: 'imagem1noticiasementesestrela.jpg',
      ),
    ],
  ),
];
