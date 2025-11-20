import 'package:flutter/material.dart';
import 'package:front_end/widgets/signin_form.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back !',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 25),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please fill in your details to sign in',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              SigninForm(),
            ],
          ),
        ),
      ),
    );
  }
}
