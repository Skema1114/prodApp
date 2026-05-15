import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';

class DescarteMenuScreen extends StatelessWidget {
  const DescarteMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Descarte de Defensivos',
      secao: SecaoTema.descarte,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Opcao(
            icone: Icons.info_outline,
            titulo: 'Como descartar',
            subtitulo: 'Tríplice lavagem, perfuração e armazenamento',
            onTap: () => Navigator.pushNamed(context, '/descarte/como'),
          ),
          const SizedBox(height: 10),
          _Opcao(
            icone: Icons.location_on_outlined,
            titulo: 'Onde descartar',
            subtitulo: 'Centrais de coleta inPEV e revendas',
            onTap: () => Navigator.pushNamed(context, '/descarte/onde'),
          ),
        ],
      ),
    );
  }
}

class _Opcao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;
  const _Opcao({
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.menuDescarte,
          child: Icon(icone, color: Colors.white),
        ),
        title:
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}

class ComoDescartarScreen extends StatelessWidget {
  const ComoDescartarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Como Descartar',
      secao: SecaoTema.descarte,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Passo(
            n: 1,
            titulo: 'Tríplice lavagem',
            texto:
                'Esvazie a embalagem no pulverizador. Adicione água até ¼ da capacidade, agite por 30s e despeje no tanque. Repita 3 vezes.',
          ),
          _Passo(
            n: 2,
            titulo: 'Inutilização',
            texto:
                'Perfure o fundo da embalagem após a lavagem para impedir a reutilização indevida.',
          ),
          _Passo(
            n: 3,
            titulo: 'Armazenamento temporário',
            texto:
                'Guarde em local coberto, ventilado, longe de pessoas, animais e alimentos. Mantenha tampa e rótulo identificáveis.',
          ),
          _Passo(
            n: 4,
            titulo: 'Devolução',
            texto:
                'Entregue em até 1 ano após a compra no posto de coleta indicado na nota fiscal — gratuitamente.',
          ),
        ],
      ),
    );
  }
}

class _Passo extends StatelessWidget {
  final int n;
  final String titulo, texto;
  const _Passo({required this.n, required this.titulo, required this.texto});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.menuDescarte,
              child: Text('$n',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(texto,
                      style:
                          const TextStyle(fontSize: 14, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OndeDescartarScreen extends StatelessWidget {
  const OndeDescartarScreen({super.key});

  static const _locais = [
    _Local(
      nome: 'Central inPEV — Campo Grande/MS',
      endereco: 'Rod. BR-262, Km 13 · (67) 3000-0000',
      tipo: 'Posto Central',
    ),
    _Local(
      nome: 'Central inPEV — Maringá/PR',
      endereco: 'Av. Industrial, 1500 · (44) 3000-0000',
      tipo: 'Posto Central',
    ),
    _Local(
      nome: 'Coopagro — Cascavel/PR',
      endereco: 'Rod. PR-486, Km 5 · (45) 3000-0000',
      tipo: 'Recebedor credenciado',
    ),
    _Local(
      nome: 'Agropecuária Estrela — Passo Fundo/RS',
      endereco: 'Av. Brasil, 4000 · (54) 3000-0000',
      tipo: 'Revenda',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Pontos de Descarte',
      secao: SecaoTema.descarte,
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _locais.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (_, i) {
          final l = _locais[i];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.location_on,
                  color: AppColors.menuDescarte),
              title: Text(l.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${l.tipo}\n${l.endereco}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class _Local {
  final String nome, endereco, tipo;
  const _Local({required this.nome, required this.endereco, required this.tipo});
}
