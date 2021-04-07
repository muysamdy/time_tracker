import 'package:flutter/material.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/screen/home.dart';
import 'package:time_tracker/screen/signin.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BaseUser>(
      stream: auth.onAuthStateChange,
      // snapshot is an object that hold data from stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          BaseUser user = snapshot.data;
          if (user == null) {
            return SignInScreen(
              // onSignIn: _updateUser,
              auth: auth,
            );
          }
          return HomeScreen(
            // onSignOut: () => _updateUser(null),
            auth: auth,
          );
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
