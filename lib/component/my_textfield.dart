import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Icon prefix;
  final String? Function(String?)? validator;

  const MytextField({
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    required this.prefix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          prefixIcon: prefix,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        validator: validator, // Assign validator function
      ),
    );
  }
}