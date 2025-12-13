/// Company: CETAM
/// Project: QParking
/// File: statistics_screen.dart
/// Created on: 15/11/2025
/// Created by: Daniel Yair Mendoza Alvarez
/// Approved by: Daniel Yair Mendoza Alvarez
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez |
/// Description: Statistics UI |
library;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';

final statsFilterProvider = StateProvider.autoDispose<int>((ref) => 0);

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(statsFilterProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- AppBar  ---
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Estadísticas de Uso',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Filter Toggles  ---
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.gray200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _FilterTab(
                      label: 'Diario',
                      isSelected: selectedFilter == 0,
                      onTap: () => ref.read(statsFilterProvider.notifier).state = 0,
                    ),
                    _FilterTab(
                      label: 'Semanal',
                      isSelected: selectedFilter == 1,
                      onTap: () => ref.read(statsFilterProvider.notifier).state = 1,
                    ),
                    _FilterTab(
                      label: 'Mensual',
                      isSelected: selectedFilter == 2,
                      onTap: () => ref.read(statsFilterProvider.notifier).state = 2,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- Chart Card  ---
              Container(
                height: 300,
                padding: const EdgeInsets.fromLTRB(16, 24, 24, 10),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => AppTheme.primary,
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.round()} hrs',
                            const TextStyle(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => _BottomTitle(value, meta),
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) return const SizedBox.shrink();
                            return Text(
                              '${value.toInt()}h',
                              style: const TextStyle(
                                color: AppTheme.gray500,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 5,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: AppTheme.gray200,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: _getChartData(selectedFilter),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- Summary Section ---
              const Text(
                'Resumen del Periodo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Total Gastado',
                      value: '\$450.00',
                      icon: Icons.monetization_on_outlined,
                      color: AppTheme.danger,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Tiempo Total',
                      value: '18h 30m',
                      icon: Icons.access_time,
                      color: AppTheme.info,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // simulate data based on filter
  List<BarChartGroupData> _getChartData(int filter) {
    const barColor = AppTheme.indigo;

    switch (filter) {
      case 0:
        return [
          _makeGroupData(0, 2, barColor),
          _makeGroupData(1, 5, barColor),
          _makeGroupData(2, 3, barColor),
          _makeGroupData(3, 8, barColor),
          _makeGroupData(4, 6, barColor),
        ];
      case 1: // Weekly (Days)
        return [
          _makeGroupData(0, 12, barColor),
          _makeGroupData(1, 8, barColor),
          _makeGroupData(2, 15, barColor),
          _makeGroupData(3, 10, barColor),
          _makeGroupData(4, 5, barColor),
          _makeGroupData(5, 18, barColor),
          _makeGroupData(6, 4, barColor),
        ];
      default: // Monthly
        return [
          _makeGroupData(0, 10, barColor),
          _makeGroupData(1, 14, barColor),
          _makeGroupData(2, 12, barColor),
          _makeGroupData(3, 16, barColor),
        ];
    }
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: AppTheme.gray100,
          ),
        ),
      ],
    );
  }
}

// Widget for Bottom Titles
class _BottomTitle extends StatelessWidget {
  final double value;
  final TitleMeta meta;

  const _BottomTitle(this.value, this.meta);

  @override
  Widget build(BuildContext context) {
    final style = const TextStyle(
      color: AppTheme.gray500,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    String text;
    switch (value.toInt()) {
      case 0: text = 'L'; break;
      case 1: text = 'M'; break;
      case 2: text = 'X'; break;
      case 3: text = 'J'; break;
      case 4: text = 'V'; break;
      case 5: text = 'S'; break;
      case 6: text = 'D'; break;
      default: text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }
}

// Widget for Filter Tabs
class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppTheme.primary : AppTheme.gray600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for Summary Cards
class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.gray500,
            ),
          ),
        ],
      ),
    );
  }
}