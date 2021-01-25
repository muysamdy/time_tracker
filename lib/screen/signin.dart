import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/windget.dart';

import 'package:time_tracker/logger.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithEmail() async {}

  Future<void> _signInWithFacebook() async {}

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          Gap(8),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            onPressed: _signInWithGoogle,
          ),
          Gap(8),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
          ),
          Gap(8),
          SignInButton(
            text: 'Sign In with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          Gap(8),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          Gap(8),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: _signInAnonymously,
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }
}
