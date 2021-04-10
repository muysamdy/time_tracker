import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/screen/home.dart';
import 'package:time_tracker/screen/signin.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<BaseUser>(
      stream: auth.onAuthStateChange,
      // snapshot is an object that hold data from stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          BaseUser user = snapshot.data;
          if (user == null) {
            return SignInScreen(
              // onSignIn: _updateUser,
            );
          }
          return HomeScreen(
            // onSignOut: () => _updateUser(null),
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
