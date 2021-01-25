import 'package:flutter/material.dart';
import 'package:time_tracker/auth.dart';

class HomeScreen extends StatelessWidget {
  final AuthBase auth;

  const HomeScreen({
    Key key,
    @required this.auth,
  }) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

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
            onPressed: () => _signOut(context),
          )
        ],
      ),
    );
  }
}
