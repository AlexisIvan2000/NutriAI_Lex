import 'package:flutter/material.dart';
import 'package:front_end/data/db.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final _formKey = GlobalKey<FormState>();

  final _age = TextEditingController();
  final _weight = TextEditingController();
  final _height = TextEditingController();

  String? _selectedSex;
  String? _selectedActivity;
  String? _selectedGoal;

  @override
  void dispose() {
    _age.dispose();
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInput(
            child: TextFormField(
              controller: _age,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }

                final age = int.tryParse(value);
                if (age == null || age <= 0) return 'Please enter a valid age';
                return null;
              },
            ),
          ),

          _buildInput(
            child: TextFormField(
              controller: _weight,
              decoration: const InputDecoration(
                labelText: 'Weight (Lbs)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }

                final w = double.tryParse(value);
                if (w == null || w <= 0) return 'Please enter a valid weight';
                return null;
              },
            ),
          ),

          _buildInput(
            child: TextFormField(
              controller: _height,
              decoration: const InputDecoration(
                labelText: 'Height (Inches)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }

                final h = double.tryParse(value);
                if (h == null || h <= 0) return 'Please enter a valid height';
                return null;
              },
            ),
          ),

          _buildInput(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedSex,
              dropdownColor: theme.scaffoldBackgroundColor,
              decoration: InputDecoration(
                label: Text(
                  'Gender',
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.bodyMedium,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelStyle: theme.textTheme.bodyMedium,
              ),
              items: Db.sex.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedSex = value),
            ),
          ),

          _buildInput(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedActivity,
              dropdownColor: theme.scaffoldBackgroundColor,
              decoration: InputDecoration(
                label: Text(
                  'Activity Level',                                                                                                                         
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.bodyMedium,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              items: Db.activityLevels.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedActivity = value),
            ),
          ),

          _buildInput(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedGoal,
              dropdownColor: theme.scaffoldBackgroundColor,
              decoration: InputDecoration(
                label: Text(
                  'Goal',
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.bodyMedium,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelStyle: theme.textTheme.bodyMedium,
              ),
              items: Db.goals.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedGoal = value),
            ),
          ),

          _buildInput(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: theme.colorScheme.secondary.withAlpha(31),
                ),
                child: Text(
                  'Submit',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({required Widget child}) {
    return Padding(padding: const EdgeInsets.only(bottom: 18.0), child: child);
  }
}
