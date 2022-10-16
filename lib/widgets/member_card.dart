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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Name'),
                const Spacer(),
                Text(
                  member.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            h(10),
            Row(
              children: [
                const Text('Zone'),
                const Spacer(),
                Text(member.zone),
              ],
            ),
            h(10),
            Row(
              children: [
                const Text('Aims Code'),
                const Spacer(),
                Text(member.aimsCode.toString()),
              ],
            ),
            h(10),
            Row(
              children: [
                const Text('Contact'),
                const Spacer(),
                Text(member.contact ?? 'N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
