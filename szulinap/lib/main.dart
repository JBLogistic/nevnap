import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:szulinap/screens/home_screen.dart';
import 'package:szulinap/screens/register.dart';
import 'package:szulinap/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SzulinapApp());
}

class SzulinapApp extends StatelessWidget {
  const SzulinapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: const Wrapper(),
        initialRoute: "/",
        routes: {
          '/registerscreen': (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Register screen"),
            ),
            body: const RegisterScreen(),
          ),
        },
      );
  }
}
