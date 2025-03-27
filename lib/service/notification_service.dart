import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await Firebase.initializeApp();

    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("Permission denied for notifications.");
      return;
    }

    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    // Initialize Local Notifications
    await _setupLocalNotifications();

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  /// Setup local notifications
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: const DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      settings,
    );
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('Token: $token');
    return token;
  }

  void isTokenRefreshed() {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      print('Token refreshed: $token');
    });
  }

  /// Handle foreground notifications
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint("Received message: ${jsonEncode(message.data)}");

    if (message.notification != null) {
      await _showLocalNotification(
        title: message.notification!.title ?? "New Notification",
        body: message.notification!.body ?? "",
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Handle background notifications (when tapped)
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint("Opened from background: ${jsonEncode(message.data)}");
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            color: Color.fromRGBO(255, 140, 0, 1),
            colorized: true);

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);
    await _localNotifications.show(0, title, body, details, payload: payload);
  }
}
