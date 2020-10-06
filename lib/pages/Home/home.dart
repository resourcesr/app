import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/components/empty_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Dashboard", back: false),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: null,
      builder: (context, snapshot) {
        return EmptyState(
          icon: Icons.home,
          text: "Coming soon",
          tSize: 1.5,
          iSize: 40.5,
        );
      },
    );
  }
}
