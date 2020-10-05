import 'package:flutter/material.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';

class ProfileUi extends StatefulWidget {
  ProfileUi({this.uid});
  String uid;
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sapController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User();
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
        appBar: AppBar(title: Text("Profile")),
        body: _buildBody(context));
  }

  void onSuccess(context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Your, account has been updated."),
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
      await user.update(widget.uid, nameController.text, sapController.text);
      onSuccess(context);
    } catch (err) {
      onError(context, err);
    }
    setState(() {
      nameController.clear();
      sapController.clear();
    });
    setState(() => isLoading = false);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeUi()));
  }

  Widget _buildBody(BuildContext context) {
    //List<Widget> children = [];

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
                              "Update Profile".toUpperCase(),
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
                              "Please enter the following detail to get update",
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
                        labelText: "sap",
                        hintText: "Enter your sap",
                        prefixIcon: const Icon(
                          Icons.security_rounded,
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
                        child: Text("Update"),
                        onPressed: () => {onSubmit(context)},
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
