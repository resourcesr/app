import 'package:flutter/material.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sapController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(context, "Register"),
        body: _buildBody(context));
  }

  //@override
  //void dispose() {
  // Clean up the controller when the widget is disposed.
  //fieldController.dispose();
  //super.dispose();
  //}

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
      await user.signup(emailController.text, passwordController.text,
          nameController.text, sapController.text);
      onSuccess(context);
    } catch (err) {
      onError(context, err);
    }
    setState(() {
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      sapController.clear();
    });
    setState(() => isLoading = false);
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      Form(
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
                              "Get Started".toUpperCase(),
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
                              "Please enter the following detail to get started",
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
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Name",
                        hintText: "Enter your name",
                        prefixIcon: const Icon(
                          Icons.people_alt,
                          color: Colors.black,
                        ),
                        prefixText: ' ',
                      ),
                    ),
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
                    child: TextFormField(
                      controller: sapController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "SAP",
                        hintText: "Enter your SAP",
                        prefixIcon: const Icon(
                          Icons.confirmation_number_sharp,
                          color: Colors.black,
                        ),
                        prefixText: ' ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.20),
                    child: TextFormField(
                      obscureText: true, // password field
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: const Icon(
                          Icons.security_rounded,
                          color: Colors.black,
                        ),
                        prefixText: ' ',
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginUi(),
                            ),
                          )
                        },
                        child: Text("Back to login?"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.20),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Register"),
                        onPressed: () => {onSubmit(context)},
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    ]);
  }
}
