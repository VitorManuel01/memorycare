import 'package:flutter/material.dart';

/// Componente que representa as informações de um teste.
class TesteInfoWidget extends StatelessWidget {
  final String dataConclusao;
  final String pontuacao;
  final String resultado;
  final String semanaDoAno;

  const TesteInfoWidget({
    super.key,
    required this.dataConclusao,
    required this.pontuacao,
    required this.resultado,
    required this.semanaDoAno,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Semana $semanaDoAno',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                'Conclusão: $dataConclusao',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildInfoTile(
                  label: 'Pontuação',
                  value: pontuacao,
                  icon: Icons.score,
                  context: context,
                ),
                const SizedBox(height: 8),
                _buildInfoTile(
                  label: 'Resultado',
                  value: resultado,
                  icon: Icons.assessment,
                  context: context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required String label,
    required String value,
    required IconData icon,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
