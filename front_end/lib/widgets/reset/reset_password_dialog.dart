import 'package:flutter/material.dart';
import 'package:front_end/services/auth_service.dart';

class ResetPasswordDialog {
  static void show(BuildContext context) {
    final emailCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Reset Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: newPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password", border: OutlineInputBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newPasswordCtrl.text != confirmCtrl.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match")),
                  );
                  return;
                }

                final result = await AuthService.instance.resetPassword(
                  email: emailCtrl.text.trim(),
                  newPassword: newPasswordCtrl.text.trim(),
                );

                if(context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result["message"])),
                );

                if (result["success"]) Navigator.pop(context);
                }
              },
              child: const Text("Change"),
            ),
          ],
        );
      },
    );
  }
}
