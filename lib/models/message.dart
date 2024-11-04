import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String senderemail;
  final String recieverID;
  final String message;
  final Timestamp timestamp;
  const Message(
      {required this.senderid,
      required this.senderemail,
      required this.recieverID,
      required this.message,
      required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'senderid':senderid,
      'senderemail':senderemail,
      'reseverid':recieverID,
      'message':message,
      'timestap':timestamp
    };
  }
}
