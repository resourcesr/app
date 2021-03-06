import "package:flutter/material.dart";
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/custom_form.dart';
import 'package:resourcesr/components/custom_input.dart';
import 'package:resourcesr/data/Contact.dart';
import 'package:resourcesr/utils/validator.dart';

class FeedbackUi extends StatefulWidget {
  @override
  _FeedbackUiState createState() => _FeedbackUiState();
}

class _FeedbackUiState extends State<FeedbackUi> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Contact feedback = Contact();
  bool isLoading = false;

  void onSubmit(context) {
    setState(() => isLoading = true);
    feedback.sent(
        nameController.text, emailController.text, commentController.text);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Sent."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
    setState(() {
      nameController.clear();
      emailController.clear();
      commentController.clear();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(context, "Feedback"),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return CustomForm(
      fromKey: null,
      imagePath: null,
      loading: isLoading,
      children: <Widget>[
        CustomInput(
          controller: nameController,
          label: "Name",
          validator: nameValidator,
          obscureText: false,
        ),
        CustomInput(
          controller: emailController,
          label: "Email",
          validator: emailValidator,
          obscureText: false,
        ),
        CustomInput(
          controller: commentController,
          label: "Comment",
          validator: nameValidator,
          obscureText: false,
          maxLines: 4,
        ),
        Padding(
          padding: const EdgeInsets.all(20.20),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).primaryColor,
              child: Text("Submit"),
              onPressed: () => {onSubmit(context)},
            ),
          ),
        ),
      ],
    );
  }
}
