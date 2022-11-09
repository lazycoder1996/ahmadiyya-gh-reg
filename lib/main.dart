import 'package:ahmadiyyagh_registration/services/api.dart';
import 'package:ahmadiyyagh_registration/views/homepage.dart';
import 'package:ahmadiyyagh_registration/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool loggedIn;
  @override
  void initState() {
    super.initState();
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MemberProvider>(create: (_) => MemberProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            prefixIconColor: Colors.black,
            suffixIconColor: Colors.black,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            circularTrackColor: Colors.black,
            color: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: loggedIn ? const HomePage() : const LoginPage(),
        ),
      ),
    );
  }
}
