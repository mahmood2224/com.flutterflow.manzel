import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ManzelFirebaseUser {
  ManzelFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ManzelFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ManzelFirebaseUser> manzelFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ManzelFirebaseUser>((user) => currentUser = ManzelFirebaseUser(user));
