import 'dart:convert';

import "package:flutter/material.dart";
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/loader.dart';
import 'package:resourcesr/utils/url.dart';
import 'package:http/http.dart' as http;

class ContributersUi extends StatefulWidget {
  @override
  _ContributersUiState createState() => _ContributersUiState();
}

class _ContributersUiState extends State<ContributersUi> {
  bool isLoading = true;
  var contributers = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      var response = await http
          .get("https://api.github.com/repos/resourcesr/app/contributors");

      var data = json.decode(response.body);
      var authors = [];
      for (var item in data) {
        var user =
            await http.get("https://api.github.com/users/${item['login']}");
        var userRespone = json.decode(user.body);

        authors.add({
          "name": userRespone['name'],
          "url": userRespone['url'],
          "avatar_url": item['avatar_url'],
          "contributions": item['contributions'],
        });
      }
      setState(() {
        contributers = authors;
        isLoading = false;
      });
    } catch (_) {}
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> children = [];

    for (var item in contributers) {
      children.add(
        Card(
          child: ListTile(
            leading: ImageAvatar(item["avatar_url"]),
            title: Text(item["name"]),
            subtitle: Text("${item["contributions"]} contributions"),
            trailing: Icon(Icons.open_in_new),
            onTap: () => {
              openUrl(item['url']),
            },
          ),
        ),
      );
    }
    if (isLoading) return Loader();
    return Container(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Contributors"),
      body: _buildBody(context),
    );
  }
}
