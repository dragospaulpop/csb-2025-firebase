import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuardWidget extends StatefulWidget {
  const GuardWidget({super.key, required this.child, required this.protected});

  final Widget child;
  final bool protected;

  @override
  State<GuardWidget> createState() => GuardWidgetState();
}

class GuardWidgetState extends State<GuardWidget> {
  bool _redirectingToSignIn = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final route = ModalRoute.of(context)?.settings.name;
        final isSignUpRoute = route == '/sign-up';

        // if (route == '/sign-up' && snapshot.data != null) {
        //   return widget.child;   
        // }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;        

        if (user == null) {          
          if (widget.protected) {
            if (!_redirectingToSignIn) {
              _redirectingToSignIn = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/sign-in',
                  (route) => false,
                );
              });
            }

            return const Scaffold(body: Center(child: Text('Redirecting...')));
          } else {
            
            
            if (route == '/sign-in' || route == '/sign-up') {
              return widget.child;   
            }

            if (!_redirectingToSignIn) {
            _redirectingToSignIn = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/sign-in',
                (route) => false,
              );
            });
          }

          return const Scaffold(body: Center(child: Text('Redirecting...')));
          }
        }


        if (widget.protected) {
          return widget.child;   
        } else {
          // Let the sign-up page finish any post-sign-up work (e.g. creating a
          // Firestore user document) before redirecting away.
          if (isSignUpRoute) return widget.child;

          if (!_redirectingToSignIn) {
            _redirectingToSignIn = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/restricted',
                (route) => false,
              );
            });
          }

          return const Scaffold(body: Center(child: Text('Redirecting...')));
        }
      },
    );
  }
}
