import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/silo.dart';
import '../../data/repositories/sessao.dart';
import '../../data/repositories/silo_repository.dart';
import '../../shared/static_data/cultura.dart';
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
  Cultura _cultura = Cultura.milho;
  final _repo = SiloRepository();
  bool _ocupado = false;

  Future<void> _salvar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _ocupado = true);
    try {
      final uid = await Sessao().userId() ?? 1;
      await _repo.inserir(Silo(
        idUsuario: uid,
        nome: _nome.text.trim(),
        produto: _cultura.nome,
        tamanho: double.parse(_tamanho.text.replaceAll(',', '.')),
      ));
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $e'),
          backgroundColor: AppColors.vermelho,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSecao(
      titulo: 'Cadastro de Silos',
      secao: SecaoTema.silo,
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            const Text('Identificação',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.menuSilo,
                )),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(
                labelText: 'Nome do silo',
                prefixIcon: Icon(Icons.label_outline_rounded),
                hintText: 'Ex: Silo Norte',
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o nome' : null,
            ),
            const SizedBox(height: 22),
            const Text('Produto armazenado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.menuSilo,
                )),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .85,
              ),
              itemCount: Cultura.values.length,
              itemBuilder: (_, i) {
                final c = Cultura.values[i];
                final sel = _cultura == c;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => setState(() => _cultura = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: sel
                            ? c.cor.withValues(alpha: .18)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: sel
                              ? c.cor
                              : Colors.black12,
                          width: sel ? 2 : 1,
                        ),
                        boxShadow: sel
                            ? [
                                BoxShadow(
                                  color: c.cor.withValues(alpha: .3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/${c.iconAsset}',
                              width: 32,
                              height: 32,
                              errorBuilder: (_, __, ___) => Icon(
                                  Icons.eco,
                                  color: c.cor)),
                          const SizedBox(height: 4),
                          Text(c.nome,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: sel
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: sel ? c.cor : Colors.black87,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            const Text('Capacidade',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.menuSilo,
                )),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tamanho,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Capacidade (litros)',
                prefixIcon: Icon(Icons.straighten_rounded),
                hintText: 'Ex: 25000',
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe a capacidade';
                final n = double.tryParse(v.replaceAll(',', '.'));
                if (n == null || n <= 0) return 'Valor inválido';
                return null;
              },
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _ocupado ? null : _salvar,
              icon: _ocupado
                  ? const SizedBox(
                      height: 18, width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.save_rounded),
              label: const Text('Salvar silo'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.menuSilo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
