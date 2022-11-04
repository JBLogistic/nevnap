import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:szulinap/screens/register.dart';

import '../providers/Checkthings.dart';
import '../providers/auth.dart';
import 'forgotPass.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String _password = "";
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Login screen"),
          ),
          key: const Key('LoginScreen'),
          body: Container(
            height: double.infinity,
            margin: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email address",
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 16),
                  TextField(
                      decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }),
                  const SizedBox(height: 16),
                  Text("Password",
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 16),
                  TextField(
                      obscureText: _obscureText,
                      decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      }),
                  TextButton(
                    onPressed: _togglePasswordVisibility,
                    child: Row(children: [
                      Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      const SizedBox(width: 8),
                      Text(_obscureText ? "Show password" : "Hide password")
                    ]),
                  ),
                  Row(children: [
                    SizedBox(
                      height: 56,
                      width: 360,
                      child: ElevatedButton(
                          onPressed: (email.isEmpty == true ||
                              _password.isEmpty == true)
                              ? null
                              : () async {
                            bool _isConnected = await CheckThings()
                                .internet("www.firebase.com");
                            bool _isCallSuccessful = await AuthService()
                                .signInWithEmailAndPassword(
                                email, _password);
                            if (_isConnected == true) {
                              if (_isCallSuccessful == true) {
                                // final isAuthenticated = await LocalAuthApi.authenticate();
                                bool isAuthenticated = true;
                                if (isAuthenticated) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const HomeScreen()));
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title:
                                      Text("Wrong email or password"),
                                    );
                                  },
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text(
                                        "You are not connected to the internet!"),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text("Login")),
                    ),
                    const SizedBox(width: 3, height: 3),
                  ]),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const forgotPass()));
                          // Navigator.pushReplacementNamed(context, '/registerscreen');
                        },
                        child: const Text("Need an account? Register here")),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const forgotPass()));
                          // Navigator.pushReplacementNamed(context, '/registerscreen');
                        },
                        child: const Text("Forgot Password?")),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}