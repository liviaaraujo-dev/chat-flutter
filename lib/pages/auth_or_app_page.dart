import 'package:chat/core/model/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class AuthOrAppPage extends StatelessWidget {

  const AuthOrAppPage({ super.key });

  Future<void> init(BuildContext context) async{
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingPage();
        }else{
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return LoadingPage();
              }else{
                return snapshot.hasData ? ChatPage() : AuthPage();
              }
            }
          );
        }

      }
    );
  }
}
