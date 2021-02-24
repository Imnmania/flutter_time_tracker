import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
// import 'package:time_tracker/services/auth.dart';
// import 'package:time_tracker/services/auth_provider.dart';
import 'package:time_tracker/services/validators.dart';
import 'package:time_tracker/widgets/custom_sign_in_btn.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';
//
import 'package:flutter/services.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  //
  // final AuthBase auth;

  // EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  //
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  // Sign in with email and password
  void _submit() async {
    // print('submit called');
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    // 'Email: ${_emailController.text}, Password: ${_passwordController.text}');
    try {
      // final auth = AuthProvider.of(context);
      final auth = Provider.of<AuthBase>(context);

      // await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInUserWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      // print(e.toString());
      // if (Platform.isIOS) {
      //   print('show CupertinoDialogue');
      // } else {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('Sign in failed'),
      //         content: Text(e.toString()),
      //         actions: [
      //           FlatButton(
      //             child: Text('OK'),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // toggle between user types
  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _submitted = false;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  // children of column widget list
  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Already have an account? Sign In';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 10,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 10,
      ),
      CustomSignInButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      TextButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(secondaryText),
      ),
    ];
  }

  // email text field
  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  // password text field
  TextField _buildPasswordTextField() {
    final showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onChanged: (password) => _updateState(),
    );
  }

  void _emailEditingComplete() {
    print('email editing complete');

    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;

    FocusScope.of(context).requestFocus(newFocus);
  }

  // main build context
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    print('Email: $_email');
    print('Password: $_password');
    setState(() {});
  }
}
