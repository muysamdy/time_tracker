import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:time_tracker/auth.dart';
import 'package:time_tracker/model.dart';
import 'package:time_tracker/windget.dart';

class EmailSignInScreen extends StatelessWidget {
  EmailSignInScreen({@required this.auth});

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: EmailSignInForm(auth: auth)),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  EmailSignInForm({@required this.auth});

  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String get email => _emailController.text;

  String get password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submit() async {
    try {
      (_formType == EmailSignInFormType.signIn)
          ? await widget.auth.signInWithEmail(email, password)
          : await widget.auth.createUserWithEmail(email, password);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  _updateState() {
    setState(() {});
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    bool submitEnabled = widget.emailValidator.isValid(email) &&
        widget.passwordValidator.isValid(password);
    Widget _buildEmailTextField(EmailSignInModel model) {
      return TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: model.emailErrorText,
          enabled: model.isLoading == false,
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
        onEditingComplete: () => _emailEditingComplete(model),
      );
    }

    Widget _buildPasswordTextField(EmailSignInModel model) {
      return TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: model.passwordErrorText,
          enabled: model.isLoading == false,
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: (password) => _updateState(),
        onEditingComplete: _submit,
      );
    }

    return [
      _buildEmailTextField(model),
      Gap(8),
      _buildPasswordTextField(model),
      Gap(8),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.isSubmit ? _submit : null,
      ),
      Gap(8),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
      // children: _buildChildren(model),
    // )
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
