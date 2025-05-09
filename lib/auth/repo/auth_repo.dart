import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static final auth = FirebaseAuth.instance;

  static signUpWithEmailAndPassword(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static signInWithEmailAndPassword(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  static getUid() {
    return auth.currentUser!.uid;
  }

  static reloadData() async {
    await auth.currentUser!.reload();
  }
}
