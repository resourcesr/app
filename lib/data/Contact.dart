import 'dart:convert';

import 'package:http/http.dart' as http;

class Contact {
  Future<http.Response> sent(String name, String email, String comment) {
    return http.post(
      'https://formspree.io/f/xrgoeybj',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        '_replyto': email,
        'comment': comment,
      }),
    );
  }
}
