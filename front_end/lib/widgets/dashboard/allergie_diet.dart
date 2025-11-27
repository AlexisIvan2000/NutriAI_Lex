import 'package:flutter/material.dart';
import 'package:front_end/data/db.dart';
import 'package:front_end/services/diet_allergy_api.dart';

class AllergieDiet extends StatefulWidget {
  const AllergieDiet({super.key});

  @override
  State<AllergieDiet> createState() => _AllergieDietState();
}

class _AllergieDietState extends State<AllergieDiet> {
  List<String> _allergies = [];
  String _diet = "No Preference";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserDietAllergies();
  }

  Future<void> loadUserDietAllergies() async {
    final res = await DietAllergyAPI.get();

    if (res != null && res["success"] == true) {
      final data = res["data"];
      setState(() {
        _diet = data["diet"] ?? "No Preference";
        _allergies = List<String>.from(data["allergies"] ?? []);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void showEditDialog() {
    List<String> tempAllergies = List.from(_allergies);
    String tempDiet = _diet;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setPopupState) {
          return AlertDialog(
            title: const Text("Edit Diet & Allergies"),
            content: SizedBox(
              width: 350,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    DropdownButtonFormField<String>(
                      initialValue: tempDiet,
                      decoration: const InputDecoration(
                        labelText: "Diet",
                        border: OutlineInputBorder(),
                      ),
                      items: Db.diets
                          .map(
                            (diet) => DropdownMenuItem(
                              value: diet,
                              child: Text(diet),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setPopupState(() => tempDiet = value!);
                      },
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Allergies",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                   
                    ...Db.allergies.map((allergy) {
                      final selected = tempAllergies.contains(allergy);

                      return CheckboxListTile(
                        title: Text(allergy),
                        value: selected,
                        onChanged: (bool? checked) {
                          setPopupState(() {
                            if (checked == true) {
                              tempAllergies.add(allergy);
                            } else {
                              tempAllergies.remove(allergy);
                            }
                          });
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () async {
                  final result = await DietAllergyAPI.save(
                    diet: tempDiet,
                    allergies: tempAllergies,
                  );

                  if (!context.mounted) return;
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result["message"] ?? "Saved")),
                  );

                  if (result["success"] == true) {
                    setState(() {
                      _diet = tempDiet;
                      _allergies = tempAllergies;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -----------------
            // ALLERGIES DISPLAY
            // -----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Allergies",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Flexible(
                  child: Text(
                    _allergies.isEmpty ? "None" : _allergies.join(", "),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // -----------------------
            // DIET DISPLAY
            // -----------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dietary Preference",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  _diet,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // -----------------------
            // EDIT BUTTON
            // -----------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: showEditDialog,
                  child: const Text("Edit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
