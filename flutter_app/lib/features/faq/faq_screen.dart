import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';
import '../../shared/widgets/secao_header.dart';

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
          'Acesse "Meus Silos" pelo menu central, toque no botão "Novo silo" '
          'e preencha nome, produto armazenado e capacidade em litros.',
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
          'Selecione 2 ou mais culturas, toque em "Gerar diagrama" e veja a '
          'sequência sugerida em formato circular. Consulte "Informações '
          'complementares" para princípios técnicos.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Dúvidas',
      secao: SecaoTema.sobre,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SecaoHeader(
            cor: AppColors.menuUsuario,
            titulo: 'Perguntas frequentes',
            subtitulo: 'Toque em uma pergunta para ver a resposta.',
            icone: Icons.help_outline_rounded,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
            child: Column(
              children: [
                for (final q in _itens) ...[
                  _CardFaq(p: q),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardFaq extends StatelessWidget {
  final _Pergunta p;
  const _CardFaq({required this.p});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: AppColors.menuUsuario.withValues(alpha: .25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.menuUsuario.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.menuUsuario.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.question_mark_rounded,
                color: AppColors.menuUsuario, size: 18),
          ),
          title: Text(p.pergunta,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(p.resposta,
                  style: const TextStyle(
                      fontSize: 14, height: 1.5, color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pergunta {
  final String pergunta, resposta;
  const _Pergunta({required this.pergunta, required this.resposta});
}
