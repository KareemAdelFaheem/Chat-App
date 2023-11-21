import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  // const MyTextButton({super.key});
  final String buttontext;
  void Function()? onTap;

  MyTextButton({super.key, required this.buttontext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text(
              buttontext,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
