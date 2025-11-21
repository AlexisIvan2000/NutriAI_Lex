import 'package:flutter/material.dart';
import 'package:front_end/widgets/dashboard/allergie_diet.dart';
import 'package:front_end/widgets/dashboard/calories_macros.dart';
import 'package:front_end/widgets/dashboard/navigation.dart';
import 'package:front_end/widgets/dashboard/profil_detail.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PERSONAL DETAILS',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
             const ProfilDetail(),
             const SizedBox(height: 10),
             Text(
                'CALORIES & MACROS',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              const CaloriesMacros(),
              const SizedBox(height: 10),
              Text(
                'ALLERGIE & DIET',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              const AllergieDiet(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigateBar(),
    );
  }
}