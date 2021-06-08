
import 'package:time_tracker/model.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) => value.isNotEmpty;
}

class EmailAndPasswordValidator {
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
  final emailValidator = NonEmptyStringValidator();
  final passwordValidator = NonEmptyStringValidator();
}

