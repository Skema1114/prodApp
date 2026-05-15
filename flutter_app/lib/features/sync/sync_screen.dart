import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/scaffold_secao.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool _sincronizando = false;
  DateTime? _ultima;

  Future<void> _sincronizar() async {
    setState(() => _sincronizando = true);
    // Stub — substituir por chamada real ao servidor remoto quando existir.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _sincronizando = false;
      _ultima = DateTime.now();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados sincronizados com sucesso.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Sincronização dos Dados',
      secao: SecaoTema.wifi,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_sincronizando ? Icons.wifi : Icons.cloud_sync,
                  size: 96, color: AppColors.menuWifi),
              const SizedBox(height: 16),
              Text(
                _sincronizando
                    ? 'Sincronizando…'
                    : 'Toque no botão abaixo para enviar/receber\nos dados do servidor.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _sincronizando ? null : _sincronizar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.menuWifi,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
                icon: const Icon(Icons.sync),
                label: const Text('Sincronizar agora'),
              ),
              if (_ultima != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Última sincronização: ${_fmt(_ultima!)}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
