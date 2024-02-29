import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:receiver/push.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notification Sender'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await PushNotificationSender.sendPushNotification(
              tokens: [
                "f2Qu5KxjQzuy6mLL0r8CrU:APA91bFxZJpPPxL6t-L_k-28G6nu4cWFMn05MavpgaWeUxYDT0SbCfY0GSNpN5wPa-eYD5wNJVO-yKJY5u8PgKmUgdw6ty2-PZSCh_OwTBqj2ok6Efoc5o_qMTkvIYo7InKAA_A4AbzT"
              ],
              title: "Test Notification",
              body: "This is a test notification.",
            );
            PushNotificationReceiver.configureFirebaseMessaging();
          },
          child: Text('Send Push Notification'),
        ),
      ),
    );
  }
}
