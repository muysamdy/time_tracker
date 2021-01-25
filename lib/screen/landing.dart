import 'package:flutter/material.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/screen/home.dart';
import 'package:time_tracker/screen/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key key, this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;

          if (user == null) {
            return SignInScreen(auth: auth);
          }
          return HomeScreen(auth: auth);
        } else {
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
