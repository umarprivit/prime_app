import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';
import 'package:prime_app/service/notification_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  FirebaseMessaging.instance.subscribeToTopic("all");

  await SharedPrefService.init();
  runApp(GetMaterialApp(
    theme: AppTheme.lightTheme,
    getPages: AppRoutes.routes,
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic("all");
  print('background message ${message.notification!.title}');
}
