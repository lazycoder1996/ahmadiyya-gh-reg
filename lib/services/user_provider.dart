import 'package:ahmadiyyagh_registration/main.dart';
import 'package:ahmadiyyagh_registration/utils/navigation.dart';
import 'package:ahmadiyyagh_registration/views/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  late MemberModel _member = returnUserDetails();
  MemberModel get member => _member;
  Future<int?> login(String aimsCode) async {
    var url =
        Uri.parse('https://ahmadiyyaghana.herokuapp.com/api/members/$aimsCode');

    var req = http.Request('GET', url);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      _member = MemberModel.fromMap(jsonDecode(resBody)["member"]);
      if (member.id == 0) {
        return -2;
      } else if (_member.role! > 0) {
        await saveUserDetails(member);
        notifyListeners();
      }
      return member.role;
    } else {
      print(resBody);
    }
    return null;
  }

  Future<void> logout(context) async {
    await prefs.setBool('loggedIn', false).then((value) {
      removeToScreen(context, const LoginPage());
    });
  }
}

saveUserDetails(MemberModel member) async {
  Map<String, dynamic> map = member.toMap();
  List<String> userDetails = [];
  for (var element in map.values) {
    userDetails.add(element.toString());
  }
  await prefs.setStringList('userDetails', userDetails);
}

returnUserDetails() {
  List<String> userDetails = prefs.getStringList('userDetails') ?? [];
  return MemberModel(
    id: int.parse(userDetails[0]),
    name: userDetails[1],
    hometown: userDetails[2],
    father: userDetails[3],
    mother: userDetails[4],
    position: userDetails[5],
    contact: userDetails[6],
    aimsCode: int.parse(userDetails[7]),
    wassiyat: int.tryParse(userDetails[8]),
    role: int.parse(userDetails[9]),
    zone: userDetails[10],
  );
}
