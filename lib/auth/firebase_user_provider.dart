import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PracticaDeExamenFirebaseUser {
  PracticaDeExamenFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

PracticaDeExamenFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PracticaDeExamenFirebaseUser> practicaDeExamenFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<PracticaDeExamenFirebaseUser>(
      (user) {
        currentUser = PracticaDeExamenFirebaseUser(user);
        return currentUser!;
      },
    );
