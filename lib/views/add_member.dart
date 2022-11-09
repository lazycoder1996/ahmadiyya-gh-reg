import 'package:ahmadiyyagh_registration/services/member_provider.dart';
import 'package:ahmadiyyagh_registration/services/user_provider.dart';
import 'package:ahmadiyyagh_registration/widgets/dropdown.dart';
import 'package:ahmadiyyagh_registration/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  TextEditingController name = TextEditingController();
  TextEditingController mother = TextEditingController();
  TextEditingController father = TextEditingController();
  TextEditingController hometown = TextEditingController();
  TextEditingController wassiyat = TextEditingController();
  TextEditingController aims = TextEditingController();
  String zone = 'Kumasi';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // backgroundColor: Colors.white,
      title: const Text(
        'Add new member',
        // style: TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: name,
              labelText: 'Fullname',
            ),
            CustomTextField(
              controller: father,
              labelText: 'Father\'s name',
            ),
            CustomTextField(
              controller: mother,
              labelText: 'Mother\'s name',
            ),
            CustomTextField(
              controller: hometown,
              labelText: 'Hometown',
            ),
            CustomTextField(
              controller: aims,
              labelText: 'Aims code',
              textInputType: TextInputType.number,
            ),
            CustomTextField(
              controller: wassiyat,
              textInputType: TextInputType.number,
              labelText: 'Wassiyat No.',
            ),
            CustomDropdown(
                value: zone,
                labelText: 'Zone',
                items: const ['Kumasi', 'Mankessim', 'Accra', 'Wa'],
                onChanged: (val) {
                  setState(() {
                    zone = val;
                  });
                }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await Provider.of<MemberProvider>(context, listen: false)
                .addMember(
              fullname: name.text.trim(),
              hometown: hometown.text.trim(),
              father: father.text.trim(),
              mother: mother.text.trim(),
              zone: zone,
              aims: aims.text.trim(),
              wassiyat: wassiyat.text.trim(),
            )
                .then((value) {
              Fluttertoast.showToast(msg: '$name added succesfully');
              name.clear();
              hometown.clear();
              father.clear();
              mother.clear();
              aims.clear();
              wassiyat.clear();
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
