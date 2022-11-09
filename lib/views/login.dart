import 'package:ahmadiyyagh_registration/services/user_provider.dart';
import 'package:ahmadiyyagh_registration/utils/navigation.dart';
import 'package:ahmadiyyagh_registration/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/sizedboxes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController aimsCode = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  int role = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    validator: (st) {
                      if (st!.isEmpty) {
                        return 'Field is required';
                      }
                      if (role == 0) {
                        return 'You are unauthorized';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: aimsCode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.code,
                        // color: Colors.black,
                      ),
                      hintText: 'Aims Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  h(20),
                  if (isLoading) const CircularProgressIndicator(),
                  if (!isLoading)
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 3.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await Provider.of<UserProvider>(context,
                                      listen: false)
                                  .login(aimsCode.text.trim())
                                  .then((value) async {
                                setState(() {
                                  role = value!;
                                  formKey.currentState!.validate();
                                  setState(() async {
                                    isLoading = false;
                                    if (role != 0) {
                                      await prefs
                                          .setBool('loggedIn', true)
                                          .then((v) {
                                        toScreen(context, const HomePage());
                                      });
                                    }
                                    role = -1;
                                  });
                                });
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
