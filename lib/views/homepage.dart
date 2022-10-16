import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:ahmadiyyagh_registration/services/api.dart';
import 'package:ahmadiyyagh_registration/utils/sizedboxes.dart';
import 'package:ahmadiyyagh_registration/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  bool isSearching = false;

  goSearching(bool val) {
    setState(() {
      isSearching = val;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Ahmadiyya Ghana'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2.5,
                child: TextField(
                  controller: search,
                  onSubmitted: (v) {
                    goSearching(v.isNotEmpty);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_outlined),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              h(20),
              StreamBuilder(
                stream: MemberProvider().getMembers(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    if (isSearching) {
                      List<MemberModel> res = snapshot.data!.where((element) {
                        return element.aimsCode.toString() ==
                                search.text.trim() ||
                            element.name
                                .toLowerCase()
                                .contains(search.text.trim().toLowerCase());
                      }).toList();
                      if (res.isEmpty) {
                        return const Center(
                          child: Text('No results found'),
                        );
                      }
                      return MemberCard(
                        member: res.first,
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!.map((e) {
                        return MemberCard(member: e);
                      }).toList(),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
