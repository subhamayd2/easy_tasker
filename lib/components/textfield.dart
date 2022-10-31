import 'package:flutter/material.dart';

class UITextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final double fontSize;

  UITextField({
    @required this.controller,
    @required this.label,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.grey.withOpacity(0.4),
          border: InputBorder.none,
          // labelText: label,
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.4),
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextStyle(fontSize: this.fontSize ?? 18),
      ),
    );
  }
}
