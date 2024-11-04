import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRegisterServices {
//auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//register
  Future<UserCredential> signupwithemailandpassword(
      String email, String password,String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //save user info if it doesn't exist

      _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email,'username':username});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }


  
}
