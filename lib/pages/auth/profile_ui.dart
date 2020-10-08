import 'package:flutter/material.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/custom_form.dart';
import 'package:riphahwebresources/components/custom_input.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';

class ProfileUi extends StatefulWidget {
  ProfileUi({this.user});
  User user;
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sapController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
        appBar: customAppBar(context, "Profile"),
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
      await widget.user
          .update(widget.user.uid, nameController.text, sapController.text);
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

    return CustomForm(
      key: _formKey,
      loading: isLoading,
      imagePath: "assets/images/Login.png",
      children: <Widget>[
        CustomInput(
          controller: nameController,
          label: "Name",
          obscureText: false,
        ),
        CustomInput(
          controller: sapController,
          label: "SAP",
          obscureText: false,
        ),
        Padding(
          padding: const EdgeInsets.all(20.20),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Update"),
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).primaryColor,
              onPressed: () => {onSubmit(context)},
            ),
          ),
        ),
      ],
    );
  }
}
