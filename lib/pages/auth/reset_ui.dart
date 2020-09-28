import 'package:flutter/material.dart';
import 'package:riphahwebresources/data/User.dart';

class ResetUi extends StatefulWidget {
  @override
  _ResetUiState createState() => _ResetUiState();
}

class _ResetUiState extends State<ResetUi> {
  TextEditingController emailController = TextEditingController();
  User user = User();
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
        appBar: AppBar(title: Text("Reset Password")),
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
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            isLoading ? LinearProgressIndicator() : SizedBox(height: 6),
            Card(
                child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(25.5),
                          child: Text(
                            "Reset Password".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.5),
                          child: Text(
                            "Enter your email to reset your password",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: "Email Address",
                      hintText: "Enter your email",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      prefixText: ' ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.20),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text("Reset"),
                      onPressed: () => {onSubmit(context)},
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
