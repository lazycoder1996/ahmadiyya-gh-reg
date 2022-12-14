import 'package:ahmadiyyagh_registration/views/login.dart';
import 'package:flutter/material.dart';

toScreen(BuildContext context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

replaceScreen(BuildContext context, page) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

removeToScreen(BuildContext context, page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}
