import 'package:flutter/material.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/custom_form.dart';
import 'package:resourcesr/components/custom_input.dart';
import 'package:resourcesr/data/User.dart';
import 'package:resourcesr/pages/Home/home_ui.dart';
import 'package:resourcesr/pages/auth/select_klass_ui.dart';
import 'package:resourcesr/utils/validator.dart';

class ProfileUi extends StatefulWidget {
  ProfileUi({@required this.user});

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
  int currentSem = 0;

  @override
  void initState() {
    setState(() {
      nameController.value = (TextEditingValue(text: widget.user.name));
      sapController.value = (TextEditingValue(text: widget.user.sap));
      currentSem = widget.user.sem ?? 1;
    });
    super.initState();
  }

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
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      try {
        await widget.user.update(nameController.text, sapController.text);
        onSuccess(context);
      } catch (err) {
        onError(context, err);
      }
    }
    setState(() => isLoading = false);
  }

  onChangeSem(value, context) async {
    setState(() => {isLoading = true, currentSem = value});
    _formKey.currentState.save();
    try {
      await widget.user.updateSem(value);

      onSuccess(context);
    } catch (err) {
      onError(context, err);
    }

    setState(() => isLoading = false);
  }

  Widget _buildBody(BuildContext context) {
    return CustomForm(
      fromKey: _formKey,
      loading: isLoading,
      imagePath: "assets/images/Login.png",
      children: <Widget>[
        CustomInput(
          controller: nameController,
          validator: nameValidator,
          label: "Name",
          obscureText: false,
        ),
        CustomInput(
          controller: sapController,
          validator: sapValidator,
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
        Padding(
          padding: const EdgeInsets.all(20.20),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Current Semester',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.all(10),
            ),
            child: DropdownButton<int>(
              items: <int>[1, 2, 3, 4, 5, 6, 7, 8].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              value: currentSem,
              onChanged: (value) async {
                await onChangeSem(value, context);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.20),
          child: TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectKlassUi(
                    user: widget.user,
                  ),
                ),
              ),
            },
            child: Text("Change Class"),
          ),
        ),
      ],
    );
  }
}
