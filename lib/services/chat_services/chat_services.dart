import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_chat_app/models/message.dart';

class SendMessageService {
  //get firebasestore instatnce & auth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //gat user stream
  Stream<List<Map<String, dynamic>>> getcurrentusers() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //sen message
  Future<void> sendmessage(String recieverID, String message) async {
    // get current user info
    final currentuserid = _auth.currentUser!.uid;
    final currentuseremail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
//create new message
    final Message newmessage = Message(
        senderid: currentuserid,
        senderemail: currentuseremail,
        recieverID: recieverID,
        message: message,
        timestamp: timestamp);
    //construct chatromm id for two users
    List<String> ids = [currentuserid, recieverID];
    ids.sort();
    String chatroomId = ids.join('_');
    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .add(newmessage.toMap());
  }


}
