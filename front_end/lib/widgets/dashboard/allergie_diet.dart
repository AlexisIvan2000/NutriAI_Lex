import 'package:flutter/material.dart';

class AllergieDiet extends StatefulWidget {
  const AllergieDiet({super.key});

  @override
  State<AllergieDiet> createState() => _AllergieDietState();
}

class _AllergieDietState extends State<AllergieDiet> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Allergies',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'None',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dietary Preferences',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Protein Rich',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                   child: Text('Edit')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
