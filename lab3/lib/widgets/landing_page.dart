import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:lab3/model/User.dart'; 
import 'package:lab3/widgets/sign_in_page.dart';
import 'package:lab3/main.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseAuth.User?>(
      stream: FirebaseAuth.FirebaseAuth.instance.authStateChanges as Stream<FirebaseAuth.User?>?,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseAuth.User? user = snapshot.data;

          if (user == null) {
            // User is not signed in
            return SignInPage();
          } else {
            // User is signed in
            return MyHomePage(title: 'Courses List');
          }
        } else {
          // Loading state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
