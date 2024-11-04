import 'package:firebase_auth/firebase_auth.dart';

class AuthLogoutServices {
//auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

//logout

  void logout() async {
    await _auth.signOut();
  }


}
