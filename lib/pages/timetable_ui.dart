import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';

class TimetableUi extends StatefulWidget {
  TimetableUi({@required this.code});
  String code;
  @override
  _TimetableUiState createState() => _TimetableUiState();
}

class _TimetableUiState extends State<TimetableUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, "Menu", back: false),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container();
  }
}
