import 'dart:math';

import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/model/chat_notification.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notifications/push_notification_service.dart';
import 'package:chat/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {

  const ChatPage({ super.key });

   @override
   Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cod3r Chat'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                onChanged: (value){
                  if(value == "logout"){
                    AuthService().logout();
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.black87,),
                          SizedBox(width: 10,),
                          Text('Sair')
                        ]
                      ),
                    )
                  )
                ], 
                icon: Icon(Icons.more_vert, color: Colors.black87,), ),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return NotificationsPage();
                      },)
                    );
                  }, 
                  icon: Icon(Icons.notifications)
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    maxRadius: 10,
                    backgroundColor: Colors.red.shade800,
                    child: Text(
                      '${Provider.of<ChatNotificationService>(context).itemsCount}', 
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(child: Messages()),
            NewMessage()
          ]),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
            // Provider.of<ChatNotificationService>(context).add(ChatNotification(title: 'Mais + m', body: '5'));
          // },
          // child: Icon(Icons.add),
        // ),
      );
  }
}
