import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:front_end/screens/user_data.dart';
import 'package:front_end/services/auth_service.dart';
import 'package:front_end/services/google_auth_service.dart';

class GoogleOAuthScreen extends StatefulWidget {
  const GoogleOAuthScreen({super.key});

  @override
  State<GoogleOAuthScreen> createState() => _GoogleOAuthScreenState();
}

class _GoogleOAuthScreenState extends State<GoogleOAuthScreen> {
  late InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('http://10.0.2.2:8000/auth/google/start'),
        ),

        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
          controller.addJavaScriptHandler(
            handlerName: 'googleLogin',
            callback: (args) async {
              final token = args[0];

              final user = await GoogleAuthService.fetchUserWithToken(token);

              if (user != null) {
                await AuthService.instance.loginWithGoogle(token, user);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const UserDataScreen()),
                  (route) => false,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Google sign-in failed")),
                );
              }
            },
          );
        },
      ),
    );
  }
}
