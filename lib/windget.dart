import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class PlatformWidget extends StatelessWidget {
  Widget buildCupertinoWidget(BuildContext context);

  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => (Platform.isIOS)
      ? buildCupertinoWidget(context)
      : buildMaterialWidget(context);
}

class CustomRaiseButton extends StatelessWidget {
  CustomRaiseButton({
    this.child,
    this.color,
    this.borderRadius: 2.0,
    this.height: 50.0,
    this.onPressed,
  }) : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class SignInButton extends CustomRaiseButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    Function onPressed,
  })  : assert(text != null),
        super(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            color: color,
            onPressed: onPressed);
}

class SocialSignInButton extends CustomRaiseButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(assetName),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 15.0),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetName),
                )
              ],
            ),
            color: color,
            onPressed: onPressed);
}

class FormSubmitButton extends CustomRaiseButton {
  FormSubmitButton({
    @required String text,
    Function onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) =>
      CupertinoDialogAction(child: child, onPressed: onPressed);

  Widget buildMaterialWidget(BuildContext context) =>
      FlatButton(child: child, onPressed: onPressed);
}

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    @required this.defaultActionText,
    this.cancelActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async => (Platform.isIOS)
      ? await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => this,
        )
      : await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (context) => this,
        );

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];

    if (cancelActionText != null) {
      actions
        ..add(
          PlatformAlertDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        );
    }
    actions
      ..add(
        PlatformAlertDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildActions(context),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildActions(context),
      );
}

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static const Map<String, String> _errors = {
    'ERROR_WRONG_PASSWORD': 'The pasword is invalid',
  };

  static String _message(PlatformException exception) =>
      _errors[exception.code] ?? exception.message;
}
