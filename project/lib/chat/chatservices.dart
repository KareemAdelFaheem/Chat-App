import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/model/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    SentMessage newmessage = SentMessage(
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomid = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('message')
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otheruserID) {
    List<String> ids = [userId, otheruserID];
    ids.sort();
    String chatroomid = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
