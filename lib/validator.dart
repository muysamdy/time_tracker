enum EmailSignInFormType { signIn, register }

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

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) =>
      EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted,
      );

  String get primaryButtonText =>
      formType == EmailSignInFormType.signIn ? 'Sign In' : 'Create an account';

  String get secondaryButtonText => formType == EmailSignInFormType.signIn
      ? 'Need an account ? Register'
      : 'Have an account ? Sign In';

  bool get isSubmit =>
      emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }
}
