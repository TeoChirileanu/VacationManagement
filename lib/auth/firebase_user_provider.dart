import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class VacationManagementFirebaseUser {
  VacationManagementFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

VacationManagementFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<VacationManagementFirebaseUser> vacationManagementFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<VacationManagementFirebaseUser>(
            (user) => currentUser = VacationManagementFirebaseUser(user));
