// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthLoginServices {
//auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//login
  Future<UserCredential> signinusingemailandpasword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //save user info if it doesn't exist
      // _firestore
      //     .collection('Users')
      //     .doc(userCredential.user!.uid)
      //     .set({'uid': userCredential.user!.uid, 'email': email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }




  User? getcurrentuser(){
    return _auth.currentUser;
  }
  
}
