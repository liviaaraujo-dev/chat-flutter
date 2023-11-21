import 'package:chat/core/services/notifications/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Notificações'),
      ),
      body: ListView. builder(
        itemCount: service.itemsCount,
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index].title), subtitle: Text(items[index].body), onTap: () => service.remove(index),);
        },
      )
    );
  }
}
