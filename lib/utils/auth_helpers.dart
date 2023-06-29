import 'package:firebase_auth/firebase_auth.dart';

bool isAuth() {
  return FirebaseAuth.instance.currentUser != null;
}

bool isProducer() {
  return true;
}
