import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/widget.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: "OK",
        );

  static String _message(PlatformException exception) {
    return _error[exception.code] ?? exception.message;
  }

  static Map<String, String> _error = {
    'ERROR_WRONG_PASSWORD': 'The password is invalid',
  };
}
