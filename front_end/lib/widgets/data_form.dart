import 'package:flutter/material.dart';
import 'package:front_end/data/db.dart';
import 'package:front_end/models/datas.dart';
import 'package:front_end/screens/dashboard.dart';
import 'package:front_end/services/personal_details_api.dart';
import 'package:front_end/utils/secure_storage.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final _formKey = GlobalKey<FormState>();

  final _ageCtrl = TextEditingController();
  final _weightLbsCtrl = TextEditingController();
  final _feetCtrl = TextEditingController();
  final _inchesCtrl = TextEditingController();

  String? _selectedSex;
  String? _selectedActivity;
  String? _selectedGoal;

  @override
  void dispose() {
    _ageCtrl.dispose();
    _weightLbsCtrl.dispose();
    _feetCtrl.dispose();
    _inchesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _input(_buildAgeField()),
          _input(_buildWeightField()),
          _input(_buildHeightFields()), 
          _input(_buildGenderDropdown(theme)),
          _input(_buildActivityDropdown(theme)),
          _input(_buildGoalDropdown(theme)),
          _input(_buildSubmitButton(theme)),
        ],
      ),
    );
  }

  
  Widget _buildAgeField() {
    return TextFormField(
      controller: _ageCtrl,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Age",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (v) {
        final n = int.tryParse(v ?? "");
        if (n == null || n <= 0) return "Enter a valid age";
        return null;
      },
    );
  }

  Widget _buildWeightField() {
    return TextFormField(
      controller: _weightLbsCtrl,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Weight (lbs)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (v) {
        final n = double.tryParse(v ?? "");
        if (n == null || n <= 0) return "Enter a valid weight";
        return null;
      },
    );
  }

  
  Widget _buildHeightFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _feetCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Feet",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            validator: (v) {
              final n = int.tryParse(v ?? "");
              if (n == null || n <= 0) return "Invalid";
              return null;
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _inchesCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Inches",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            validator: (v) {
              final n = int.tryParse(v ?? "");
              if (n == null || n < 0 || n > 11) return "0–11";
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      decoration: _dropdownDecoration(theme, "Gender"),
      items: Db.sex
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => setState(() => _selectedSex = v),
      validator: (v) => v == null ? "Required" : null,
    );
  }

  Widget _buildActivityDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      decoration: _dropdownDecoration(theme, "Activity Level"),
      items: Db.activityLevels
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => setState(() => _selectedActivity = v),
      validator: (v) => v == null ? "Required" : null,
    );
  }

  Widget _buildGoalDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      decoration: _dropdownDecoration(theme, "Goal"),
      items: Db.goals
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => setState(() => _selectedGoal = v),
      validator: (v) => v == null ? "Required" : null,
    );
  }



  Widget _buildSubmitButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary.withAlpha(31),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _submit,
        child: Text(
          "Submit",
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
      ),
    );
  }



  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = await SecureStorage.getUser();
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }

    final details = PersonalDetailsInput(
      age: int.parse(_ageCtrl.text),
      weightLbs: double.parse(_weightLbsCtrl.text),
      heightFeet: int.parse(_feetCtrl.text),
      heightInches: int.parse(_inchesCtrl.text),
      gender: _selectedSex!,
      activityLevel: _selectedActivity!,
      goal: _selectedGoal!,
    );

    final result = await PersonalDetailsAPI.savePersonalDetails(
      user.id,
      details,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result["message"])));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen()), 
      (route) => false,
    );
  }

 

  Widget _input(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 18.0), child: child);

  InputDecoration _dropdownDecoration(ThemeData theme, String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: theme.textTheme.bodyMedium,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}
