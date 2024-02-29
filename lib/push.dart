import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class PushNotificationSender {
  static Future<void> sendPushNotification({
    required List<String> tokens,
    required String title,
    required String body,
  }) async {
    final String urlString = "https://fcm.googleapis.com/fcm/send";
    final Map<String, dynamic> requestBody = {
      "registration_ids": tokens,
      "notification": {"title": title, "body": body},
      "data": {"user": "test_id"}
    };

    final http.Response response = await http.post(
      Uri.parse(urlString),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAwcLM8e0:APA91bH31NwZaRElA5CiJAhhKTCEu8h7HxRQeT3NkQ_5Cd1LFSH--I_YxZNzXR2HlWt0tL9UoiePLVI5RYkcVZCD6VYQXaZPQPeeghsS0mNlmRSXxzBRqYCuQm-OI7HRCuW183cCn0lI",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Push notification sent successfully.");
    } else {
      print(
          "Failed to send push notification. Status code: ${response.statusCode}");
    }
  }
}

class PushNotificationReceiver {
  static void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Received push notification: ${message.notification?.title}, ${message.notification?.body}");
      // Handle the received message here
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("Received background message: ${message.notification?.body}");
      // Handle background messages here
    });
  }
}
