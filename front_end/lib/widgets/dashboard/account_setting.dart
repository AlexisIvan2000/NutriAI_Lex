import 'package:flutter/material.dart';
import 'package:front_end/screens/signin.dart';
import 'package:front_end/services/auth_api.dart';
import 'package:front_end/services/auth_service.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String firstname = "First Name";
  String lastname = "Last Name";
  String email = "Email";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final profile = await AuthAPI.getCurrentUser();
    if (profile != null) {
      setState(() {
        firstname = profile.firstName;
        lastname = profile.lastName;
        email = profile.email;
      });
    } else {
      setState(() {
        firstname = "First Name";
        lastname = "Last Name";
        email = "Email";
      });
    }
  }

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
                  'First Name',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  ' $firstname',
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
                  'Last Name',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  ' $lastname',
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
                Text('Email', style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  ' $email',
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
                  onPressed: () {
                    showDeleteAccountDialog(context);
                  },
                  child: const Text('Delete Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),

          ElevatedButton(
            child: const Text('Delete'),
            onPressed: () async {
              final result = await AuthService.instance.deleteAccount();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(result["message"])));

              if (result["success"]) {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SigninScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      );
    },
  );
}
