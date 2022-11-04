import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerEmailPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      )).user;
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
  Future signOut() async {
    await _auth.signOut();
  }
}
