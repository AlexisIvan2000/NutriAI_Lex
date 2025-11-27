import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/services/nutrition_api.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  Map<String, dynamic>? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNutrition();
  }

  Future<void> loadNutrition() async {
    final res = await NutritionAPI.getSummary();
    setState(() {
      data = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data == null) {
      return const Text("No nutrition data available");
    }

    final double proteins = (data!["proteins"] as num).toDouble();
    final double carbs = (data!["carbs"] as num).toDouble();
    final double fats = (data!["fats"] as num).toDouble();

    return Column(
      children: [
        Text(
          "Daily Calorie intake: ${(data!["tdee"] as num).round()} kcal",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),

        SizedBox(
          height: 200,
          width: 200,
          child: CustomPaint(
            painter: MacroPieChart(
              proteins: proteins,
              carbs: carbs,
              fats: fats,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _macroItem("Protein", proteins, Colors.blue),
            _macroItem("Carbs", carbs, Colors.orange),
            _macroItem("Fats", fats, Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _macroItem(String label, double grams, Color color) {
    return Column(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(height: 4),
        Text("$label: ${grams.toStringAsFixed(0)}g"),
      ],
    );
  }
}

class MacroPieChart extends CustomPainter {
  final double proteins;
  final double carbs;
  final double fats;

  MacroPieChart({
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = proteins + carbs + fats;

    if (total == 0) return;

    final paint = Paint()..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    double startAngle = -pi / 2;

    paint.color = Colors.blue;
    final proteinSweep = (proteins / total) * 2 * pi;
    canvas.drawArc(rect, startAngle, proteinSweep, true, paint);
    startAngle += proteinSweep;

    paint.color = Colors.orange;
    final carbsSweep = (carbs / total) * 2 * pi;
    canvas.drawArc(rect, startAngle, carbsSweep, true, paint);
    startAngle += carbsSweep;

    paint.color = Colors.red;
    final fatsSweep = (fats / total) * 2 * pi;
    canvas.drawArc(rect, startAngle, fatsSweep, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
