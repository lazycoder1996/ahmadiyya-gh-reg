import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? labelText;
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 6),
      child: TextField(
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          labelText: labelText,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
