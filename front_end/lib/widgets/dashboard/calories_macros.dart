import 'package:flutter/material.dart';
import 'package:front_end/services/nutrition_api.dart';
import 'package:front_end/widgets/reset/adjust_calories_dialog.dart';

class CaloriesMacros extends StatefulWidget {
  const CaloriesMacros({super.key});

  @override
  State<CaloriesMacros> createState() => _CaloriesMacrosState();
}

class _CaloriesMacrosState extends State<CaloriesMacros> {
  Map<String, dynamic>? summary;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadSummary();
  }

  Future<void> loadSummary() async {
    final res = await NutritionAPI.getSummary();

    setState(() {
      if (res == null) {
        errorMessage = "Unable to load nutrition summary";
      } else {
        summary = res;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            errorMessage!,
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
          ),
        ),
      );
    }

    final calories = summary!["tdee"].round();
    final proteins = summary!["proteins"].round();
    final carbs = summary!["carbs"].round();
    final fats = summary!["fats"].round();

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row("Daily Calorie Intake", "$calories kcal", context),
            const SizedBox(height: 12),
            _row("Protein", "$proteins g", context),
            const SizedBox(height: 12),
            _row("Carbs", "$carbs g", context),
            const SizedBox(height: 12),
            _row("Fat", "$fats g", context),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    showAdjustCaloriesDialog(context, summary!, loadSummary);
                  },
                  child: const Text("Adjust"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        Text(
          value,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
