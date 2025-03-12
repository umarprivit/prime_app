import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/config/config.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/course_screens/quiz_note_screen.dart';
import 'package:prime_app/screens/course_screens/quiz_screen.dart';
import 'package:prime_app/screens/course_screens/request_course.dart';
import 'package:prime_app/screens/dashboard/dashboard_screen.dart';
import 'package:prime_app/screens/starting_screens/intro_screen.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';

import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
  runApp(GetMaterialApp(
    theme: AppTheme.lightTheme,
    getPages: AppRoutes.routes,
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
