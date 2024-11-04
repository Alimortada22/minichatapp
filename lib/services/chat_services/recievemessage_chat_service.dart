import 'package:cloud_firestore/cloud_firestore.dart';

class ResieveMessageService{
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    //recive message
  Stream<QuerySnapshot<Map<String, dynamic>>> getmessages(String userid, otheruserid) {
    List<String> userids = [userid, otheruserid];
    userids.sort();
    String chatroomId = userids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestap', descending: false).snapshots();
  }
}