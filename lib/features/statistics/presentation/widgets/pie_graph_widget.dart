/**import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:qparking/core/constants/colors/colors_constants.dart';
import 'package:qparking/features/statistics/statistics_exports.dart';

class ParkingDistributionPie extends StatelessWidget {
  final List<ParkingStat> data;

  const ParkingDistributionPie({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.fold<int>(0, (sum, e) => sum + e.value);
    final theme = Theme.of(context);

    final colors = <Color>[
      PRIMARY_COLOR,
      Colors.blue.shade400,
      Colors.blue.shade200,
      Colors.blue.shade100,
    ];

    final sections = <PieChartSectionData>[
      for (int i = 0; i < data.length; i++)
        _buildSection(
          color: colors[i % colors.length],
          value: data[i].value.toDouble(),
          percentage: total == 0 ? 0 : (data[i].value * 100 / total),
        ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(
        //   'Entries by Parking Lot',
        //   style: theme.textTheme.titleLarge,
        //   textAlign: TextAlign.center,
        // ),
        const SizedBox(height: 4),
        Text(
          'Entradas totales: $total',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.2,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 48,
              sectionsSpace: 2,
              startDegreeOffset: -90,
              pieTouchData: PieTouchData(enabled: true),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ===== Leyenda inferior =====
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            for (int i = 0; i < data.length; i++)
              _LegendItem(
                color: colors[i % colors.length],
                label:
                    '${data[i].name} • ${total == 0 ? '0.0' : (data[i].value * 100 / total).toStringAsFixed(1)}%',
              ),
          ],
        ),
      ],
    );
  }

  PieChartSectionData _buildSection({
    required Color color,
    required double value,
    required double percentage,
  }) {
    final showTitle = percentage >= 5;
    return PieChartSectionData(
      color: color,
      value: value,
      radius: 70,
      title: showTitle ? '${percentage.toStringAsFixed(1)}%' : '',
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titlePositionPercentageOffset: 0.6,
      showTitle: true,
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(label),
      ],
    );
  }
}
    */
