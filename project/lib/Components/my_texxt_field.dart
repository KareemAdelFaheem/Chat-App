import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final bool obsecuretext;
  final String hinttext;

  MyTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.obsecuretext});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecuretext,
      decoration: InputDecoration(
      
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600)),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hinttext),
    );
  }
}
