import 'package:flutter/material.dart';
import 'package:time_tracker/service/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;

  AuthProvider({@required this.auth, this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  // final auth = AuthProvide.of(contex);
  static AuthBase of(BuildContext context) {
    AuthProvider provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
