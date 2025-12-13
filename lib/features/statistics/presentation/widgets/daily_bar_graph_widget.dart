/**import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qparking/core/constants/constants_exports.dart';

/// Pill-style bar chart for hours per day (Mon..Sun)
class DailyBarGraphWidget extends StatelessWidget {
  final List<double> hours; // length must be 7

  const DailyBarGraphWidget({super.key, required this.hours})
    : assert(hours.length == 7, 'hours must have 7 items');

  @override
  Widget build(BuildContext context) {
    // ===== Rango fijo de horas (0..10) =====
    const double minY = 0;
    const double maxY = 10;

    // ===== Construcción de grupos con barras “píldora” =====
    final groups = <BarChartGroupData>[
      for (int i = 0; i < hours.length; i++)
        BarChartGroupData(
          x: i,
          barsSpace: 0,
          barRods: [
            BarChartRodData(
              toY: hours[i].clamp(minY, maxY),
              width: 18,
              borderRadius: BorderRadius.circular(20), // forma píldora
              // Gradiente vertical usando SOLO colores permitidos
              gradient: const LinearGradient(
                colors: [PRIMARY_COLOR, INFO_COLOR],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              // Pista de fondo hasta 10 horas
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxY,
                color: SECONDARY_COLOR.withOpacity(0.18),
              ),
            ),
          ],
        ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SECONDARY_COLOR.withOpacity(0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: SECONDARY_COLOR.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          minY: minY,
          maxY: maxY,
          barGroups: groups,

          // ===== Grid opcional y muy sutil =====
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            horizontalInterval: 2, // líneas cada 2 h
            getDrawingHorizontalLine: (_) => FlLine(
              color: SECONDARY_COLOR.withOpacity(0.15),
              strokeWidth: 1,
            ),
          ),

          // ===== Bordes discretos =====
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: SECONDARY_COLOR.withOpacity(0.30),
              width: 1,
            ),
          ),

          // ===== Etiquetas en español (L M X J V S D) =====
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  // ===== Muestra el valor encima de cada barra como entero =====
                  final idx = value.toInt();
                  if (idx < 0 || idx >= hours.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      hours[idx].clamp(minY, maxY).toStringAsFixed(0),
                      style: const TextStyle(
                        color: SECONDARY_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 2,
                getTitlesWidget: (value, meta) {
                  // 0,2,4,6,8,10
                  if (value % 2 != 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: 11,
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                  final idx = value.toInt();
                  final label = (idx >= 0 && idx < days.length)
                      ? days[idx]
                      : '';
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: SECONDARY_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ===== Tooltips en español =====
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => SECONDARY_COLOR.withOpacity(0.9),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                const daysLong = [
                  'Lunes',
                  'Martes',
                  'Miércoles',
                  'Jueves',
                  'Viernes',
                  'Sábado',
                  'Domingo',
                ];
                final day = daysLong[group.x.toInt()];
                return BarTooltipItem(
                  '$day\n${rod.toY.toStringAsFixed(1)} h',
                  const TextStyle(fontWeight: FontWeight.w700),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
    */
