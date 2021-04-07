import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/screen/signin.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.auth});

  final AuthBase auth;

//
//   const HomeScreen({
//     Key key,
//     @required this.auth,
//   }) : super(key: key);
//
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

//   Future<void> _confirmSignOut(BuildContext context) async {
//     final didRequestSignOut = await PlatformAlertDialog(
//       title: "Logout",
//       content: "Are you sure that you want to logout?",
//       cancelActionText: "Cancel",
//       defaultActionText: "Logout",
//     ).show(context);
//     if (didRequestSignOut == true) {
//       _signOut(context);
//     }
//   }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
