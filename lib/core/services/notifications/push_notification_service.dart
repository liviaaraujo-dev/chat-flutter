import 'package:chat/core/model/chat_notification.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier{
  List<ChatNotification> _items = [ChatNotification(title: 'title', body: '5'), ChatNotification(title: 'title', body: '5'), ChatNotification(title: 'title', body: '5')];

  int get itemsCount{
    return _items.length;
  }

   List<ChatNotification> get items{
    return [..._items];
  }

  void add(ChatNotification notification){
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i){
    _items.removeAt(i);
  }
}