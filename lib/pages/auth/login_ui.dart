import 'package:flutter/material.dart';
import 'package:riphahwebresources/pages/auth/register_ui.dart';
import 'package:riphahwebresources/pages/auth/reset_ui.dart';
import 'package:riphahwebresources/components/buttons.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        appBar: AppBar(title: Text("Login")), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: <Widget>[
        isLoading ? LinearProgressIndicator() : SizedBox(height: 6),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
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
                                builder: (context) => RegisterUi()),
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
                        child: Text("Login"),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.5),
                    child: SizedBox(
                      width: double.infinity,
                      child: GoogleSignInButton(
                        onPressed: () => {},
                        //darkMode: true,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ]),
    );
  }
}
