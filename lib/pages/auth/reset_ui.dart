import 'package:flutter/material.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/custom_form.dart';
import 'package:riphahwebresources/components/custom_input.dart';
import 'package:riphahwebresources/data/User.dart';

class ResetUi extends StatefulWidget {
  @override
  _ResetUiState createState() => _ResetUiState();
}

class _ResetUiState extends State<ResetUi> {
  TextEditingController emailController = TextEditingController();
  User user = User("");
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //@override
  //void dispose() {
  // Clean up the controller when the widget is disposed.
  //fieldController.dispose();
  //super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(context, "Reset Password"),
        body: _buildBody(context));
  }

  void onSuccess(context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Password reset link has been set to your email."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
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
    try {
      await user.resetPassword(emailController.text);
      onSuccess(context);
    } catch (err) {
      onError(context, err);
    }
    setState(() => isLoading = false);
    setState(() => emailController.clear());
  }

  Widget _buildBody(BuildContext context) {
    return CustomForm(
        key: _formKey,
        loading: isLoading,
        imagePath: "assets/images/forgot.png",
        children: <Widget>[
          CustomInput(
            controller: emailController,
            label: "Email",
            obscureText: false,
          ),
          Padding(
            padding: const EdgeInsets.all(20.20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Reset"),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                onPressed: () => {onSubmit(context)},
              ),
            ),
          )
        ]);
  }
}
