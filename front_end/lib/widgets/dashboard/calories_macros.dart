import 'package:flutter/material.dart';

class CaloriesMacros extends StatefulWidget {
  const CaloriesMacros({super.key});

  @override
  State<CaloriesMacros> createState() => _CaloriesMacrosState();
}

class _CaloriesMacrosState extends State<CaloriesMacros> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily Calorie Intake',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('2500 kcal',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],              
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Protein',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('150 g',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],              
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Carbs',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('300 g',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],              
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fat',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('70 g',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],              
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {}, 
                  child: const Text('Adjust'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}