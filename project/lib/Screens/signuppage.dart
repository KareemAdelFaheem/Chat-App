import 'package:flutter/material.dart';
import 'package:project/Components/My_Text_Button.dart';
import 'package:project/Components/my_texxt_field.dart';
import 'package:project/Services/auth/auth_gate.dart';
import 'package:project/Services/authservices.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  void Function()? onTap;
  SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  void SignUp() async {
    if (_confirmpasswordcontroller.text != _passwordcontroller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password doesn't match")));
      return;
    }
    final authservice = Provider.of<AuthServices>(context, listen: false);
    try {
      await authservice.signingUp(
          _emailcontroller.text, _passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message_rounded,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Chat App",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: _emailcontroller,
                    hinttext: "Email",
                    obsecuretext: false),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: _passwordcontroller,
                    hinttext: "Password",
                    obsecuretext: false),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: _confirmpasswordcontroller,
                    hinttext: "Confirm Password",
                    obsecuretext: false),
                const SizedBox(
                  height: 50,
                ),
                MyTextButton(
                  buttontext: "Sign up",
                  onTap: SignUp,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Sign in now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
