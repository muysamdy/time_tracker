import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  // Future<void> _signOut(BuildContext context) async {
  //   try {
  //     final auth =
  //   }
  // }

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
            onPressed: null,
            // onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
    );
  }
}
