import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _itens = [
    _Pergunta(
      pergunta: 'O que é o ProdAPP?',
      resposta:
          'Aplicativo voltado ao produtor rural com módulos de gestão de silos, '
          'calendário de plantio, dicionário de pragas, rotação de culturas, '
          'descarte de defensivos e notícias do agronegócio.',
    ),
    _Pergunta(
      pergunta: 'Como cadastrar um silo?',
      resposta:
          'Acesse "Meus Silos" pelo menu central, toque no botão "+" e preencha '
          'nome, produto armazenado e capacidade em litros.',
    ),
    _Pergunta(
      pergunta: 'Os dados ficam apenas no celular?',
      resposta:
          'Sim. Os dados são armazenados localmente em SQLite. Use o módulo '
          '"Sincronização" para subir para a nuvem quando estiver online.',
    ),
    _Pergunta(
      pergunta: 'Esqueci minha senha. O que faço?',
      resposta:
          'A versão atual usa autenticação local. Em caso de perda, cadastre-se '
          'novamente com novo e-mail. Sincronização em nuvem está no roadmap.',
    ),
    _Pergunta(
      pergunta: 'Como funciona o módulo de rotação?',
      resposta:
          'Selecione 2 ou mais culturas, toque em "Criar diagrama" e veja a '
          'sequência sugerida em formato circular. Consulte "Informações '
          'complementares" para princípios técnicos.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Dúvidas',
      secao: SecaoTema.sobre,
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _itens.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (_, i) {
          final q = _itens[i];
          return Card(
            child: ExpansionTile(
              title: Text(q.pergunta,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(q.resposta,
                      style: const TextStyle(fontSize: 14, height: 1.4)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Pergunta {
  final String pergunta, resposta;
  const _Pergunta({required this.pergunta, required this.resposta});
}
