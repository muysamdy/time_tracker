import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_tracker/windget.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  // Future<void> _signInWithGoogle(BuildContext context)async {
  //   try {
  //     await s
  //   }
  // }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () {},
            // onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          Gap(8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
          ),
          Gap(8.0),
          SignInButton(
            text: 'Sign In with email',
            textColor: Colors.teal[700],
            onPressed: () {},
          ),
          Gap(8.0),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.lime[300],
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
