import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(String e, String p) async {
    try {
      AuthResult result =
          await _auth.createUserWithEmailAndPassword(email: e, password: p);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (e) {
      return null;
    }
  }
}
