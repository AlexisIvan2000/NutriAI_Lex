import 'package:flutter/material.dart';
import 'package:front_end/services/ai_nutrition_api.dart';
import 'package:front_end/widgets/dashboard/navigation.dart';
import 'package:front_end/services/pdf_export.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  Map<String, dynamic>? plan;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPlan();
  }

  Future<void> loadPlan() async {
    setState(() => loading = true);
    final res = await AiNutritionAPI.generatePlan();

    if (res["success"] == true) {
      setState(() {
        plan = res["plan"];
        loading = false;
      });
    } else {
      setState(() => loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : plan == null
                ? const Center(child: Text("No plan available"))
                : SingleChildScrollView(child: _buildPlan()),
      ),
      bottomNavigationBar: const NavigateBar(),
    );
  }

  
  Widget _buildPlan() {
    final rawWeek = plan?["weekly_nutrition_plan"];

    if (rawWeek == null || rawWeek is! Map<String, dynamic>) {
      return const Center(
          child: Text("Invalid plan format from server.",
              style: TextStyle(color: Colors.red)));
    }

  
    final List<Map<String, dynamic>> days = rawWeek.entries.map((entry) {
      return {
        "day": entry.key,
        "meals": entry.value["meals"] ?? {},
      };
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Weekly Nutrition Plan",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),

        ...days.map((day) => _buildDayCard(day)),

        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: loadPlan,
              icon: const Icon(Icons.refresh),
              label: const Text("Regenerate Plan"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await exportPlanAsPdf(plan!);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("PDF exported")),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Export PDF"),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildDayCard(Map<String, dynamic> day) {
    final meals = day["meals"] as List<dynamic>? ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day["day"],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

           
            ...meals.map((meal) => _buildMeal(meal)),
          ],
        ),
      ),
    );
  }

  /// --------------------------
  /// DISPLAY A MEAL + INGREDIENTS
  /// --------------------------
  Widget _buildMeal(dynamic meal) {
    final String title = meal["meal"] ?? "Meal";
    final ingredients = meal["ingredients"] as List<dynamic>? ?? [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

          const SizedBox(height: 6),

          ...ingredients.map(
            (ing) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                "- ${ing["name"]} (${ing["grams"]}g)",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
