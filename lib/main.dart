import 'package:csb_2025_firebase/pages/guard.dart';
import 'package:csb_2025_firebase/pages/home.dart';
import 'package:csb_2025_firebase/pages/restricted.dart';
import 'package:csb_2025_firebase/pages/sign-in.dart';
import 'package:csb_2025_firebase/pages/sign-up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => GuardWidget(protected: false, child: HomePage()),
        '/sign-in': (context) => GuardWidget(protected: false, child: SignInPage()),
        '/sign-up': (context) => SignUpPage(),
        '/restricted': (context) => GuardWidget(protected: true, child: RestrictedPage()),
      },
    );
  }
}
