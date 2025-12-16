import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestrictedPage extends StatefulWidget {
  const RestrictedPage({super.key});

  @override
  State<RestrictedPage> createState() => _RestrictedPageState();
}

class _RestrictedPageState extends State<RestrictedPage> {
  bool _redirectingToSignIn = false;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;  

        return Scaffold(
          appBar: AppBar(title: const Text('Restricted Page')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('This is a restricted page.'),
                Text('Logged in as: ${user?.email ?? '(no email)'}'),
                TextButton(
                  onPressed: logOut,
                  child: const Text('Log Out'),
                ),
              ],
            ),
          ),
        );
    
  }
}
