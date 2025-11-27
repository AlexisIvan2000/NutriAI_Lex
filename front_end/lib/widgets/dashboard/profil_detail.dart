import 'package:flutter/material.dart';
import 'package:front_end/screens/user_data.dart';
import 'package:front_end/services/personal_details_api.dart';
import 'package:front_end/utils/secure_storage.dart';

double kgToLbs(double kg) => kg / 0.453592;

Map<String, int> cmToFeetInches(double cm) {
  final totalInches = cm / 2.54;
  final feet = totalInches ~/ 12;
  final inches = (totalInches % 12).round();
  return {"feet": feet, "inches": inches};
}

class ProfilDetail extends StatefulWidget {
  const ProfilDetail({super.key});

  @override
  State<ProfilDetail> createState() => _ProfilDetailState();
}

class _ProfilDetailState extends State<ProfilDetail> {
  Map<String, dynamic>? details;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPersonalDetails();
  }

  Future<void> loadPersonalDetails() async {
    final user = await SecureStorage.getUser();
    if (user == null) return;

    final res = await PersonalDetailsAPI.getPersonalDetails(user.id);

    setState(() {
      details = res["data"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (details == null) {
      return _noDataCard(context);
    }

    final age = details!["age"] ?? "—";
    final gender = details!["gender"] ?? "—";
    final activity = details!["activity_level"] ?? "—";
    final goal = details!["goal"] ?? "—";

    String weightDisplay = "—";
    if (details!["weight"] != null) {
      final weightLbs = kgToLbs(details!["weight"]).toStringAsFixed(1);
      weightDisplay = "$weightLbs lbs";
    }

    String heightDisplay = "—";
    if (details!["height"] != null) {
      final h = cmToFeetInches(details!["height"]);
      heightDisplay = "${h["feet"]} ft ${h["inches"]} in";
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(context, "Age", "$age years"),
            _row(context, "Current Weight", weightDisplay),
            _row(context, "Height", heightDisplay),
            _row(context, "Gender", "$gender"),
            _row(context, "Activity Level", "$activity"),
            _row(context, "Goal", "$goal"),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const UserDataScreen()),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _noDataCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "No personal details saved yet.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
