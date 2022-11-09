import 'dart:io';

import 'package:ahmadiyyagh_registration/models/member.dart';
import 'package:ahmadiyyagh_registration/services/api.dart';
import 'package:ahmadiyyagh_registration/utils/sizedboxes.dart';
import 'package:ahmadiyyagh_registration/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TextEditingController search = TextEditingController();
  bool isSearching = false;
  bool done = false;

  goSearching(bool val) {
    setState(() {
      isSearching = val;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    search.dispose();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isSearching;
      },
      child: Scaffold(
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
                    textInputAction: TextInputAction.search,
                    controller: search,
                    onSubmitted: (v) {
                      if (v.isNotEmpty) {
                        setState(() {
                          done = true;
                        });
                      }
                    },
                    onChanged: (v) {
                      setState(() {
                        done = false;
                      });
                      goSearching(v.isNotEmpty);
                    },
                    onTap: () {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search by Aims code',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_outlined),
                        onPressed: () async {
                          var scanArea =
                              (MediaQuery.of(context).size.width < 400 ||
                                      MediaQuery.of(context).size.height < 400)
                                  ? 200.0
                                  : 350.0;
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                              overlay: QrScannerOverlayShape(
                                  borderColor: Colors.red,
                                  borderRadius: 10,
                                  borderLength: 30,
                                  borderWidth: 10,
                                  cutOutSize: scanArea),
                              onPermissionSet: (ctrl, p) =>
                                  _onPermissionSet(context, ctrl, p),
                            );
                          }));
                        },
                      ),
                    ),
                  ),
                ),
                h(20),
                if (isSearching && !done)
                  Lottie.asset('assets/icons/search.json'),
                StreamBuilder(
                  stream: MemberProvider().getMembers(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      if (done) {
                        List<MemberModel> res = snapshot.data!.where((element) {
                          return element.aimsCode.toString() ==
                              search.text.trim();
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
                      if (!isSearching && !done) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!.map((e) {
                            return MemberCard(member: e);
                          }).toList(),
                        );
                      }
                      return const SizedBox();
                    }

                    return const CircularProgressIndicator();
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
