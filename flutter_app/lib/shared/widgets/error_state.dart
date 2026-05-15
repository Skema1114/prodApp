import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ErrorState extends StatelessWidget {
  final String mensagem;
  final String? detalhe;
  final Future<void> Function()? onRetry;

  const ErrorState({
    super.key,
    required this.mensagem,
    this.detalhe,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.vermelho.withValues(alpha: .12),
              ),
              child: const Icon(Icons.error_outline,
                  size: 56, color: AppColors.vermelho),
            ),
            const SizedBox(height: 20),
            Text(mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                )),
            if (detalhe != null) ...[
              const SizedBox(height: 8),
              Text(detalhe!,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  )),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => onRetry!(),
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
