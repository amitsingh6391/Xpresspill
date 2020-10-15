import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signupWithEmail(String email, String password) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;
      if (user != null) return true;
      return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }
}
