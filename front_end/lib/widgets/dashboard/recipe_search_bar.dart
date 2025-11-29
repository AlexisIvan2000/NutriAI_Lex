import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecipeSearchBar extends StatefulWidget {
  const RecipeSearchBar({super.key});

  @override
  State<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  final TextEditingController controller = TextEditingController();
  List suggestions = [];
  bool loading = false;

  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() => suggestions = []);
      return;
    }

    final url = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/search.php?s=$query");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        suggestions = data["meals"] ?? [];
      });
    }
  }

  void searchMeal(String query) {
    FocusScope.of(context).unfocus();
    controller.text = query;
    fetchRecipeData(query);
    setState(() => suggestions = []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        if (suggestions.isNotEmpty) _buildSuggestionsList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withAlpha(15),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: fetchSuggestions,
              onSubmitted: searchMeal,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search for recipes, ingredients, or diets",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              blurRadius: 10, color: Colors.black.withAlpha(15))
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, i) {
          final meal = suggestions[i];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(meal["strMealThumb"], width: 45),
            ),
            title: Text(meal["strMeal"]),
            onTap: () => searchMeal(meal["strMeal"]),
          );
        },
      ),
    );
  }

 
  Future<void> fetchRecipeData(String query) async {
    final url = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/search.php?s=$query");

    final response = await http.get(url);
    if (!mounted) return;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["meals"] != null) {
        showRecipeListBottomSheet(context, data["meals"]);
      } else {
        showRecipeListBottomSheet(context, []);
      }
    }
  }
}

void showRecipeListBottomSheet(BuildContext context, List meals) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.7,
        child: meals.isEmpty
            ? const Center(
                child: Text("No results found",
                    style: TextStyle(fontSize: 18)),
              )
            : ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          meal["strMealThumb"],
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(meal["strMeal"]),
                      subtitle: Text(meal["strArea"] ?? ""),
                      onTap: () =>
                          showMealDetailsBottomSheet(context, meal),
                    ),
                  );
                },
              ),
      );
    },
  );
}

void showMealDetailsBottomSheet(BuildContext context, Map meal) {
  final ingredients = <String>[];

  // extraction auto : strIngredient1, strIngredient2...
  for (int i = 1; i <= 20; i++) {
    final ingredient = meal["strIngredient$i"];
    final measure = meal["strMeasure$i"];
    if (ingredient != null &&
        ingredient.toString().isNotEmpty &&
        ingredient != "") {
      ingredients.add("$ingredient - $measure");
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.92,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PHOTO
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(meal["strMealThumb"],
                      height: 220, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),

              // NOM
              Text(
                meal["strMeal"],
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Cat + origine
              Text(
                "${meal["strCategory"]} • ${meal["strArea"]}",
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),

              const SizedBox(height: 20),

              // INGRÉDIENTS
              const Text("Ingredients",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              ...ingredients.map((i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("• $i",
                        style: const TextStyle(fontSize: 16)),
                  )),

              const SizedBox(height: 20),

              // INSTRUCTIONS
              const Text("Instructions",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Text(
                meal["strInstructions"],
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      );
    },
  );
}
