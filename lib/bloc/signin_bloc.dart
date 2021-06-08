import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker/service/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;
  final _isLoadingController = StreamController<bool>();

  // An input stream for the steam builder
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<BaseUser> _signIn(Future<BaseUser> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<BaseUser> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<BaseUser> signInWithGoogle() async => _signIn(auth.signInWithGoogle);

  Future<BaseUser> signInWithFacebook() async => _signIn(auth.signInWithFacebook);
}
