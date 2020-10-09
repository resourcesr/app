import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/custom_form.dart';
import 'package:riphahwebresources/components/custom_input.dart';
import 'package:riphahwebresources/data/Contact.dart';

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
      key: null,
      imagePath: null,
      loading: isLoading,
      children: <Widget>[
        CustomInput(
          controller: nameController,
          label: "Name",
          obscureText: false,
        ),
        CustomInput(
          controller: emailController,
          label: "Email",
          obscureText: false,
        ),
        CustomInput(
          controller: commentController,
          label: "Comment",
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
