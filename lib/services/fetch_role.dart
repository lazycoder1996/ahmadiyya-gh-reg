import 'dart:convert';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:http/http.dart' as http;

Future<int?> fetchRole(String aimsCode) async {
  var url =
      Uri.parse('https://ahmadiyyaghana.herokuapp.com/api/members/$aimsCode');

  var req = http.Request('GET', url);
  MemberModel member;
  var res = await req.send();
  final resBody = await res.stream.bytesToString();
  if (res.statusCode >= 200 && res.statusCode < 300) {
    member = MemberModel.fromMap(jsonDecode(resBody)["member"]);
    return member.role;
  } else {}
  return null;
}
