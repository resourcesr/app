import 'package:flutter/material.dart';
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resourcesr/components/loader.dart';
import 'package:resourcesr/data/User.dart';
import 'package:resourcesr/data/klasses.dart';

class SelectKlassUi extends StatefulWidget {
  SelectKlassUi({@required this.user});
  User user;
  @override
  _SelectKlassUiState createState() => _SelectKlassUiState();
}

class _SelectKlassUiState extends State<SelectKlassUi> {
  String dropdownValue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(context, "Select Class"),
      body: Center(child: _buildBody(context)),
    );
  }

  void onSubmit(id) {
    widget.user.updateKlass(id);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Your, account has been updated."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
    Navigator.pushNamed(context, '/');
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Klasss().getAllKlasses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loader();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    final items = snapshot.toList();
    //List<String> klasses = [];
    //Map kMap = {};
    List<Widget> children = [];
    for (var item in items) {
      /*var i = item.data['name'].toString().replaceAll(" ", "-");
      klasses.add(i);
      kMap[i] = item.documentID;*/
      children.add(
        Card(
          child: ListTile(
            leading: TextAvatar(text: item.data['name']),
            title: Text(item.data['name']),
            subtitle: Text(
                "${item.data['cr']} - ${item.data['program'].toString().toUpperCase()}"),
            tileColor: (item.documentID == widget.user.klass)
                ? Colors.green[200]
                : Colors.transparent,
            onTap: () => {
              onSubmit(item.documentID),
            },
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: children,
    );
    /*return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 5,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        onSubmit(kMap[newValue]);
      },
      items: klasses.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );*/
  }
}
