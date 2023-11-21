import 'package:cloud_firestore/cloud_firestore.dart';

class SentMessage {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  SentMessage(
      {required this.message,
      required this.receiverId,
      required this.senderEmail,
      required this.senderId,
      required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
