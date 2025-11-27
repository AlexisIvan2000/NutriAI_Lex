import 'package:flutter/material.dart';
import 'package:front_end/services/nutrition_api.dart';

void showAdjustCaloriesDialog(
  BuildContext context,
  Map<String, dynamic> initialData,
  Function refresh,
) {
  final caloriesCtrl =
      TextEditingController(text: (initialData["tdee"] as num).round().toString());
  final proteinsCtrl =
      TextEditingController(text: (initialData["proteins"] as num).round().toString());
  final carbsCtrl =
      TextEditingController(text: (initialData["carbs"] as num).round().toString());
  final fatsCtrl =
      TextEditingController(text: (initialData["fats"] as num).round().toString());

  Future<void> syncFromCalories() async {
    int cal = int.parse(caloriesCtrl.text);

    
    int p = (cal * 0.30 / 4).round();
    int c = (cal * 0.45 / 4).round();
    int f = (cal * 0.25 / 9).round();

    proteinsCtrl.text = p.toString();
    carbsCtrl.text = c.toString();
    fatsCtrl.text = f.toString();
  }

  Future<void> syncFromMacros() async {
    int p = int.tryParse(proteinsCtrl.text) ?? 0;
    int c = int.tryParse(carbsCtrl.text) ?? 0;
    int f = int.tryParse(fatsCtrl.text) ?? 0;

    int calories = (p * 4) + (c * 4) + (f * 9);
    caloriesCtrl.text = calories.toString();
  }

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Adjust Daily Intake"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: caloriesCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Daily Calories"),
              onChanged: (_) => syncFromCalories(),
            ),
            TextField(
              controller: proteinsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Proteins (g)"),
              onChanged: (_) => syncFromMacros(),
            ),
            TextField(
              controller: carbsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Carbs (g)"),
              onChanged: (_) => syncFromMacros(),
            ),
            TextField(
              controller: fatsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Fats (g)"),
              onChanged: (_) => syncFromMacros(),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () async {
              final result = await NutritionAPI.updateCalorieIntake(
                calories: int.parse(caloriesCtrl.text),
                proteins: int.parse(proteinsCtrl.text),
                carbs: int.parse(carbsCtrl.text),
                fats: int.parse(fatsCtrl.text),
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result?["message"] ?? "")),
              );

              Navigator.pop(context);
              refresh();
            },
          ),
        ],
      );
    },
  );
}
