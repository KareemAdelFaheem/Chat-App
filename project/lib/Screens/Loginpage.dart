import 'package:flutter/material.dart';
import 'package:project/Components/My_Text_Button.dart';
import 'package:project/Components/my_texxt_field.dart';
import 'package:project/Services/authservices.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  void SignIn() {
    final authService = Provider.of<AuthServices>(context, listen: false);
    try {
      authService.SigningIn(_emailcontroller.text, _passwordcontroller.text);
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
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: SingleChildScrollView(
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
                  height: 50,
                ),
                MyTextButton(
                  buttontext: "Sign in",
                  onTap: SignIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("a new member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
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
