import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'login_screen.dart';

class forgotPass extends StatefulWidget {
  const forgotPass({Key? key}) : super(key: key);

  @override
  State<forgotPass> createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  String _emailContr = "";

  @override
  bool _validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value));
  }

  Future passReset() async {
    try {
      if (_validateEmail(_emailContr)) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailContr);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("That's not a valid email!"),
            );
          },
        );
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Email does not exist!"),
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Password reset page'),
          elevation: 0,
        ),
        body: Container(
            height: double.infinity,
            margin: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text(
                      "Type in your Email address and we will send you a password reset link",
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 16),
                  TextField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          _emailContr = value;
                        });
                      }),
                  const SizedBox(height: 16),
                  MaterialButton(
                    onPressed: () {
                      passReset();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text('Reset password'),
                    color: Colors.blue,
                  )
                ]))));
  }
}
