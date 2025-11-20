import 'package:flutter/material.dart';
import 'package:front_end/screens/signin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
     resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/avatar.png',
                            width: 230,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.35),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                const SizedBox(height: 30),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nutriailex",
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                Text(
                  "Your intelligent companion for better eating, smarter training, and real results.",
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),
          
                const SizedBox(height: 50),
          
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => SigninScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.05,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 1,
                  ),
                  child: Text(
                    "Get Started",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
