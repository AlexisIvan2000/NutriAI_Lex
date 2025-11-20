import 'package:flutter/material.dart';
import 'package:front_end/widgets/data_form.dart';

class UserDataScreen  extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please enter your personal data',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              const DataForm(),
            ],
          ),
        
        ),
      ),
    );
  }

}