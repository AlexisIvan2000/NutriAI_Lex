import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/screens/home.dart'; 


final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(23, 247, 78, 6),
  surface: const Color.fromARGB(255, 179, 199, 176)
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    titleSmall: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black),
  ),
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
