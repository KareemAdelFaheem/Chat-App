import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Components/my_texxt_field.dart';
import 'package:project/chat/chatservices.dart';

class ChatPage extends StatefulWidget {
  final String receiveruseremail;
  final String receiveruserid;
  const ChatPage(
      {super.key,
      required this.receiveruseremail,
      required this.receiveruserid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontoller = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void SendingMessage() async {
    if (_messagecontoller.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiveruserid, _messagecontoller.text);
      _messagecontoller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiveruseremail),
        ),
        body: Column(
          children: [
            Expanded(child: _buildmessageList()),
            _buildMessageInput(),
          ],
        ));
  }

  Widget _buildmessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiveruserid, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      
      ),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: alignment,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data['senderEmail']),
          Text(
            data['message'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        SizedBox(
            height: 80,
            width: MediaQuery.sizeOf(context).width * 0.85,
            child: MyTextField(
                controller: _messagecontoller,
                hinttext: "Enter your message here",
                obsecuretext: false)),
        IconButton(onPressed: SendingMessage, icon: const Icon(Icons.send))
      ],
    );
  }
}
