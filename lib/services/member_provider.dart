import 'dart:async';
import 'dart:convert';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';

class MemberProvider {
  late final Stream<List<MemberModel>> _members;
  Stream<List<MemberModel>> get members => _members;

  Stream<List<MemberModel>> getMembers() async* {
    Future<List<MemberModel>> members() async {
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.members);

      var req = http.Request('GET', url);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var body = jsonDecode(resBody)["members"];
        return body.isEmpty
            ? []
            : List.generate(
                body.length,
                ((index) => MemberModel.fromMap(body[index])),
              ).reversed.toList();
      } else {}
      return [];
    }

    yield* Stream.periodic(const Duration(milliseconds: 100))
        .asyncMap((event) => members());
  }

  Future<void> addMember({
    required String fullname,
    required String hometown,
    required String father,
    required String mother,
    required String zone,
    required String aims,
    String? wassiyat,
  }) async {
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.members);

    Map<String, String> body = {
      "Fullname": fullname,
      "Hometown": hometown,
      "Father": father,
      "Mother": mother,
      "Zone": zone,
      "AimsCode": aims,
      "Role": '0',
      "Wassiyat": wassiyat!,
    };

    var req = http.MultipartRequest('POST', url);
    req.fields.addAll(body);
    print(req.fields);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(resBody);
    }
  }
}
