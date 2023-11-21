import 'dart:io';
import 'dart:async';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/chat_user.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  // static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for(final user in authChanges){
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential= await auth.createUserWithEmailAndPassword(email: email, password: password);

    if(credential.user == null ) return;

    final imageName = '${credential.user!.uid}.jpg';

    final imageURL = await _uploadUserImage(image, imageName);

    credential.user?.updateDisplayName(name);
    credential.user?.updatePhotoURL(imageURL);
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static Future<String?> _uploadUserImage(File? image, String imageName) async {  
    if(image == null) return null;
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    imageRef.putFile(image).whenComplete(() => {});
    return await imageRef.getDownloadURL();
  }

  static ChatUser _toChatUser(User user)=> ChatUser(id: user.uid, name: user.displayName ?? user.email!.split('@')[0], email: user.email!, imageURL: user.photoURL ?? 'assets/images/avatar.png');
}
