import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<BaseUser> get onAuthStateChange;

  Future<BaseUser> currentUser();

  Future<BaseUser> signInAnonymously();

  Future<BaseUser> signInWithGoogle();

  Future<BaseUser> signInWithFacebook();

  Future<BaseUser> signInWithEmail(String email, String password);

  Future<BaseUser> createUserWithEmail(String email, String password);

  Future<void> signOut();
}

class BaseUser {
  BaseUser({@required this.uid});

  final String uid;
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  BaseUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return BaseUser(uid: user.uid);
  }

  @override
  Stream<BaseUser> get onAuthStateChange =>
      _firebaseAuth.authStateChanges().map(_userFromFirebase);

  @override
  Future<BaseUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<BaseUser> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      // find the way to access token.
      GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<BaseUser> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(
          result.accessToken.token,
        ),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'sign in aborted by user',
      );
    }
  }

  Future<BaseUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<BaseUser> signInWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<BaseUser> createUserWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await _firebaseAuth.signOut();
    await facebookLogin.logOut();
    await googleSignIn.signOut();
  }
}
