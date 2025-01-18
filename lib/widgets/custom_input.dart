import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const Input({
    required this.labelText,
    required this.icon,
    required this.keyboardType,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 18),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      cursorColor: Colors.white,
    );
  }
}
