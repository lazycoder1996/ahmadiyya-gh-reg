import 'dart:async';
import 'dart:convert';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:http/http.dart' as http;

class MemberProvider {
  late final Stream<List<MemberModel>> _members;
  Stream<List<MemberModel>> get members => _members;

  Stream<List<MemberModel>> getMembers() async* {
    Future<List<MemberModel>> members() async {
      var url = Uri.parse('https://ahmadiyyaghana.herokuapp.com/api/members');

      var req = http.Request('GET', url);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var body = jsonDecode(resBody)["members"];
        return body.isEmpty
            ? []
            : List.generate(
                body.length, ((index) => MemberModel.fromMap(body[index])));
      } else {}
      return [];
    }

    yield* Stream.periodic(const Duration(milliseconds: 100))
        .asyncMap((event) => members());
  }
}
