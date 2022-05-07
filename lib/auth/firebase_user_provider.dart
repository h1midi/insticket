import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class InsticketFirebaseUser {
  InsticketFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

InsticketFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<InsticketFirebaseUser> insticketFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<InsticketFirebaseUser>(
        (user) => currentUser = InsticketFirebaseUser(user));
