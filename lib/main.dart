import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/screen/landing.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create:(context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingScreen(),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
