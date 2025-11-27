import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MacrosPieChart extends StatelessWidget {
  final double proteins;
  final double carbs;
  final double fats;

  const MacrosPieChart({
    super.key,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    final total = proteins + carbs + fats;

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 50,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: Colors.blueAccent,
                  value: proteins,
                  title: "${((proteins / total) * 100).round()}%",
                  radius: 60,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.orangeAccent,
                  value: carbs,
                  title: "${((carbs / total) * 100).round()}%",
                  radius: 60,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: fats,
                  title: "${((fats / total) * 100).round()}%",
                  radius: 60,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

      
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _legendItem(Colors.blueAccent, "Proteins: ${proteins.round()} g"),
            _legendItem(Colors.orangeAccent, "Carbs: ${carbs.round()} g"),
            _legendItem(Colors.green, "Fats: ${fats.round()} g"),
          ],
        )
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
