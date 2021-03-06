import 'package:flutter/material.dart';
import 'package:resourcesr/components/buttons.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/custom_form.dart';
import 'package:resourcesr/components/custom_input.dart';
import 'package:resourcesr/data/User.dart';
import 'package:resourcesr/pages/auth/register_ui.dart';
import 'package:resourcesr/pages/auth/reset_ui.dart';
import 'package:resourcesr/pages/dashboard_splash_ui.dart';
import 'package:resourcesr/utils/validator.dart';
import 'package:resourcesr/config.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User("");
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  //@override
  //void dispose() {
  // Clean up the controller when the widget is disposed.
  //fieldController.dispose();
  //super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(context, "Login"),
        body: _buildBody(context));
  }

  void onSuccess(context, u) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Your, account has been loggedin."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DashboardSplashUi(user: u)));
  }

  void onError(context, err) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(err.message),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
  }

  void onSubmit(context) async {
    setState(() => isLoading = true);
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      try {
        var u = await user.login(emailController.text, passwordController.text);
        onSuccess(context, u);
      } catch (err) {
        onError(context, err);
      }
    }
    setState(() {
      emailController.clear();
      passwordController.clear();
    });
    setState(() => isLoading = false);
  }

  void onGoogleSubmit(context) async {
    setState(() => isLoading = true);
    try {
      var u = await user.loginWithGoogle();
      onSuccess(context, u);
    } catch (err) {
      onError(context, err);
    }
    setState(() => isLoading = false);
  }

  Widget _buildBody(BuildContext context) {
    return CustomForm(
      fromKey: _formKey,
      imagePath: "assets/images/Login.png",
      loading: isLoading,
      children: <Widget>[
        CustomInput(
          controller: emailController,
          validator: emailValidator,
          label: "Email",
          obscureText: false,
        ),
        CustomInput(
          controller: passwordController,
          validator: passwordValidatorl,
          label: "Password",
          obscureText: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterUi()),
                )
              },
              child: Text("Do not have account?"),
            ),
            FlatButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetUi()),
                )
              },
              child: Text("Forget password?"),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.20),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).primaryColor,
              child: Text("Login"),
              onPressed: () => {onSubmit(context)},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.5),
          child: SizedBox(
            width: double.infinity,
            child: GoogleSignInButton(
              onPressed: () => {onGoogleSubmit(context)},
              darkMode: currentTheme.isDark,
            ),
          ),
        ),
        SizedBox(height: 30)
      ],
    );
  }
}
