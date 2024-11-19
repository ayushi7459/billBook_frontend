import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    if (message == null || message.notification == null) {
      return Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context)!.notification),
        ),
        body:  Center(
          child: Text(
            AppLocalizations.of(context)!.no_notifications,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.notification),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(
              message.notification!.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              message.notification!.body.toString(),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
