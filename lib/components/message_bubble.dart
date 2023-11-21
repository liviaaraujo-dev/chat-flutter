import 'dart:io';

import 'package:chat/core/model/chat_message.dart';
import 'package:flutter/material.dart';

class MessgaBubble extends StatelessWidget {
  final ChatMessage message;
  final bool  belognsToCurrentUser;
  const MessgaBubble({super.key, required this.message, required this.belognsToCurrentUser});

  Widget _showUserImage(String? imageURL){
    ImageProvider? provider;
    final uri = Uri.parse(imageURL!);
    if(uri.path.contains('assets/images/avatar.png')){
      provider = AssetImage('assets/images/avatar.png');
    }else if(uri.scheme.contains('http')){
      provider = NetworkImage(uri.toString());
    }else{
      provider = FileImage(File(uri.toString()));
    }
    return CircleAvatar(backgroundColor: Colors.pink, backgroundImage: provider,);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Row(
          mainAxisAlignment: belognsToCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belognsToCurrentUser ? Colors.grey.shade300 : Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: belognsToCurrentUser ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: belognsToCurrentUser ? Radius.circular(0) : Radius.circular(12)
                ),

              ),
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8
              ),
              child: Column(
                crossAxisAlignment: belognsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(message.userName, style: TextStyle(fontWeight: FontWeight.bold, color: belognsToCurrentUser ? Colors.black : Colors.white),),
                  Text(message.text,
                    textAlign: belognsToCurrentUser ? TextAlign.right : TextAlign.left,                 
                   style: TextStyle(color: belognsToCurrentUser ? Colors.black : Colors.white),),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belognsToCurrentUser ? null : 165,
          right: belognsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageURL)
        ),
      ],
    );
  }
}
