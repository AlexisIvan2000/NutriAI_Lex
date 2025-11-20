import 'package:flutter/material.dart';
import 'package:front_end/screens/dashboard.dart';
import 'package:front_end/screens/favorites.dart';
import 'package:front_end/screens/settings.dart';


class NavigateBar extends StatefulWidget {
  const NavigateBar({super.key});

  @override
  State<NavigateBar> createState() => _NavigateBarState();
}

class  _NavigateBarState extends State<NavigateBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (Route<dynamic> route) => false,
      );
      } else if (_selectedIndex == 1) {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const FavoritesScreen()),
        (Route<dynamic> route) => false,
      );
      } else if (_selectedIndex == 2) {
       Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
        (Route<dynamic> route) => false,
      );
      } else if (_selectedIndex == 3) {
        // Navigate to Profile
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      fixedColor: Theme.of(context).colorScheme.primary.withAlpha(200),
      backgroundColor: Theme.of(context).colorScheme.surface,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}