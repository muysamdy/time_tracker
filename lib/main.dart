import 'package:flutter/material.dart';
import 'package:time_tracker/screen/signin_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SignInScreen(),
    );
  }
}

void main() => runApp(MyApp());
