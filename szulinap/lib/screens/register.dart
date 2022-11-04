import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:szulinap/providers/Checkthings.dart';
import 'package:szulinap/providers/auth.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = "";
  String _email = "";
  String _password = "";
  String _passwordAgain = "";
  bool _obscureText = true;

  bool _validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value));
  }

  bool _validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value));
  }

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
        return MediaQuery(
          data: const MediaQueryData(),
          child: Scaffold(
            appBar: AppBar(
              title: Text("Register screen"),
            ),
            key: Key('RegisterScreen'),
            body: Container(
              height: double.infinity,
              margin: EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type in your full name",
                        style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 8),
                    TextField(
                        decoration:
                        InputDecoration(border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        }),
                    SizedBox(height: 16),
                    Text("Valid email is required",
                        style: Theme.of(context).textTheme.subtitle2),
                    TextField(
                        decoration:
                        InputDecoration(border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        }),
                    SizedBox(height: 16),
                    Text("Create password",
                        style: Theme.of(context).textTheme.subtitle2),
                    Text(
                      "(minimum 8 characters, containing an uppercase letter and a number)",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      obscureText: _obscureText,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 16),
                    Text("Confirm password",
                        style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 8),
                    TextField(
                      obscureText: _obscureText,
                      onChanged: (value) {
                        setState(() {
                          _passwordAgain = value;
                        });
                      },
                      decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                    ),
                    TextButton(
                      onPressed: _togglePasswordVisibility,
                      child: Row(children: [
                        Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        SizedBox(width: 8),
                        Text(_obscureText ? "Show password" : "Hide password")
                      ]),
                    ),
                    Center(
                      child: SizedBox(
                        height: 56,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: (_name.isEmpty == true ||
                              _email.isEmpty == true ||
                              _validateEmail(_email) == false ||
                              !(_password == _passwordAgain) ||
                              _validatePassword(_password) == false)
                              ? null
                              : () async {
                            bool _isConnected = await CheckThings()
                                .internet("www.firebase.com");
                            bool _isCallSuccessful = await AuthService()
                                .registerEmailPassword(_email, _password);
                            if (_isConnected == true) {
                              if (_isCallSuccessful == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const HomeScreen()));
                                //Navigator.pushReplacementNamed(context, "/polls");
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.blueAccent,
                                  content: Row(
                                    children: [
                                      const Icon(
                                          Icons.check_circle_rounded),
                                      const SizedBox(width: 8),
                                      Expanded(
                                          child: Text("Success",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1)),
                                    ],
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text(
                                          "This email is already in use!"),
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
                          child: const Text(
                            "Register",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:
                          const Text("Already have an account? Log in!")),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}