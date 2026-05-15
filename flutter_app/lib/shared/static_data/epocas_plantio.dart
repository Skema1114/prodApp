import 'cultura.dart';

class EpocaPlantio {
  final String janelaIdeal;
  final String regiao;
  final String solo;
  final String observacoes;
  const EpocaPlantio({
    required this.janelaIdeal,
    required this.regiao,
    required this.solo,
    required this.observacoes,
  });
}

const _epocas = <Cultura, EpocaPlantio>{
  Cultura.arroz: EpocaPlantio(
    janelaIdeal: 'Setembro a Novembro',
    regiao: 'Sul e Centro-Oeste',
    solo: 'Argiloso, com boa retenção hídrica',
    observacoes:
        'Plantar logo após preparo do solo. Em arroz irrigado, garantir lâmina d\'água estável até a fase reprodutiva.',
  ),
  Cultura.milho: EpocaPlantio(
    janelaIdeal: 'Safra: Setembro a Novembro · Safrinha: Janeiro a Março',
    regiao: 'Todas as regiões produtoras',
    solo: 'Bem drenado, pH 5,5–6,5',
    observacoes:
        'Adubação de base com fósforo e potássio. Atenção ao zoneamento agrícola para evitar veranicos.',
  ),
  Cultura.soja: EpocaPlantio(
    janelaIdeal: 'Outubro a Dezembro',
    regiao: 'Sul, Centro-Oeste, MATOPIBA',
    solo: 'Bem drenado, com Ca e Mg corrigidos',
    observacoes:
        'Tratamento de sementes com inoculante (Bradyrhizobium) é essencial. Respeitar vazio sanitário (junho–setembro).',
  ),
  Cultura.trigo: EpocaPlantio(
    janelaIdeal: 'Maio a Julho',
    regiao: 'Sul (RS, SC, PR) e parte de SP/MS',
    solo: 'Bem drenado, pH 5,5–6,5',
    observacoes:
        'Evitar geadas no florescimento. Cultivar resistente à brusone é fundamental no Brasil Central.',
  ),
};

EpocaPlantio epocaDe(Cultura c) => _epocas[c]!;
