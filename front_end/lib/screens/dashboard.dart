import 'package:flutter/material.dart';
import 'package:front_end/main.dart';
import 'package:front_end/services/auth_api.dart';
import 'package:front_end/widgets/dashboard/navigation.dart';
import 'package:front_end/widgets/dashboard/nutrition.dart';
import 'package:front_end/widgets/dashboard/recipe_search_bar.dart';
import 'package:front_end/widgets/dashboard/tips.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String username = "User";
  
  @override
  void initState(){
    super.initState();
    loadUser();
  }
  void loadUser() async {
    final profile = await AuthAPI.getCurrentUser();
    if (profile != null) {
      setState(() {
        username = profile.firstName; 
      });

    } else {
      setState(() {
        username = "User";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(width: 8),
            Text(
              'Welcome, $username !',
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
            RecipeSearchBar(),
            const SizedBox(height: 20),
             Align(
              alignment: Alignment.centerLeft,
              child: Text('Calories & macros', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
            ),
            const SizedBox(height: 20),
           Nutrition(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Tips', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
            ),
            const SizedBox(height: 20),
            const Tips(),
          ],
        ),
      ),
      bottomNavigationBar: const NavigateBar(),
    );
  }
}
