import 'package:ahmadiyyagh_registration/main.dart';
import 'package:ahmadiyyagh_registration/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  late MemberModel member;
  Future<int?> login(String aimsCode) async {
    var url =
        Uri.parse('https://ahmadiyyaghana.herokuapp.com/api/members/$aimsCode');

    var req = http.Request('GET', url);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      member = MemberModel.fromMap(jsonDecode(resBody)["member"]);
      notifyListeners();
      return member.role;
    } else {}
    return null;
  }

  Future<void> logout(context) async {
    await prefs.setBool('loggedIn', false).then((value) {
      toLogin(context);
    });
  }
}
