import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/silo.dart';
import '../../data/repositories/sessao.dart';
import '../../data/repositories/silo_repository.dart';
import '../../shared/widgets/scaffold_secao.dart';

class CadastroSiloScreen extends StatefulWidget {
  const CadastroSiloScreen({super.key});

  @override
  State<CadastroSiloScreen> createState() => _CadastroSiloScreenState();
}

class _CadastroSiloScreenState extends State<CadastroSiloScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _tamanho = TextEditingController();
  String _produto = 'Milho';
  final _produtos = const ['Milho', 'Soja', 'Arroz', 'Trigo'];
  final _repo = SiloRepository();
  bool _ocupado = false;

  Future<void> _salvar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _ocupado = true);
    final uid = await Sessao().userId() ?? 1;
    await _repo.inserir(Silo(
      idUsuario: uid,
      nome: _nome.text.trim(),
      produto: _produto,
      tamanho: double.parse(_tamanho.text.replaceAll(',', '.')),
    ));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Cadastro de Silos',
      secao: SecaoTema.silo,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(labelText: 'Nome do silo'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _produto,
                decoration: const InputDecoration(labelText: 'Produto'),
                items: _produtos
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setState(() => _produto = v ?? 'Milho'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tamanho,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration:
                    const InputDecoration(labelText: 'Capacidade (litros)'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a capacidade';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null || n <= 0) return 'Valor inválido';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _ocupado ? null : _salvar,
                child: _ocupado
                    ? const SizedBox(
                        height: 22, width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Salvar silo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
