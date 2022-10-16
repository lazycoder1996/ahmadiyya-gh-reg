import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:ahmadiyyagh_registration/utils/sizedboxes.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;
  const MemberCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'profile picture',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: Image.asset('assets/images/rahman.jpeg').image,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                h(10),
                Text(member.zone),
                h(10),
                Text(member.aimsCode.toString()),
                h(10),
                Text(member.contact ?? 'N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
