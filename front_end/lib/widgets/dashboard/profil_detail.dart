import 'package:flutter/material.dart';

class ProfilDetail extends StatefulWidget {
  const ProfilDetail({super.key});

  @override
  State<ProfilDetail> createState() => _ProfilDetailState();
}

class _ProfilDetailState extends State<ProfilDetail> {
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
                Text('Age',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('25 years',
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
                Text('Current Weight',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('220 lbs',
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
                Text('Height',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('6 ft 2 in',
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
                Text('Sex',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('Male',
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
                Text('Activity Level',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('Moderately active',
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
                Text('Goal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('Lose Fat',
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
                  onPressed: () {
                    // Implement edit functionality here
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
}