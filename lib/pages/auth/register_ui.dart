import 'package:flutter/material.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  final fieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register")), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      Form(
        child: Padding(
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
                      controller: fieldController,
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
                      controller: fieldController,
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
                      controller: fieldController,
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
                      controller: fieldController,
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
                        onPressed: () => {},
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
