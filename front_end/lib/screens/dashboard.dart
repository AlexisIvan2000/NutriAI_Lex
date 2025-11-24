import 'package:flutter/material.dart';
import 'package:front_end/widgets/dashboard/navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(width: 8),
            Text(
              'Welcome, Alexis!',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchBar(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              controller: _searchController,
              hintText: 'Search for recipes, ingredients, or diets',
              leading: const Icon(Icons.search),
            ),
            const SizedBox(height: 20),
            //  Other dashboard content goes here(macros)
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Tips', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigateBar(),
    );
  }
}
