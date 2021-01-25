import 'package:flutter/material.dart';
import 'package:time_tracker/screen/home.dart';
import 'package:time_tracker/screen/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  User _user;

  void _updateUser(User user) {
    setState(() => _user = user);
  }

  Future<void> _checkCurrentUser() async {
    User user = await FirebaseAuth.instance.currentUser;
    _updateUser(user);
  }

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInScreen(onSignIn: _updateUser);
    }
    return HomeScreen(onSignOut: () => _updateUser(null));
  }
}
