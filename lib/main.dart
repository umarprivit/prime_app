import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/notification_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
  await NotificationService().initNotifications();
  // RENAME DOCUMENT
  // await FirestoreService().renameDocument('mcqs', 'gk part 1', 'accounts jobs');

  // DATA ENTRY IN FIREBASE
  // await dataEntry();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  FirebaseMessaging.instance.subscribeToTopic("all");
  String? deviceId = await SharedPrefService().getDeviceId();
  print(deviceId);
  if (!(deviceId!.isEmpty)) {
    print(
        "Trying to delete expire courses registerd on this device with device id $deviceId");
    await FirestoreService().isExpired(deviceId: deviceId);
  }

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

// Map<int, List<Map<String, dynamic>>> mcqsByPage = {
//   9: [
//     {
//       "question": "\"Jigsaw\" is an active learning technique that involves:",
//       "options": ["Students becoming experts on subtopics and teaching peers", "Silent individual reading", "Teacher-led lectures only", "Multiple-choice testing"],
//       "answer": "Students becoming experts on subtopics and teaching peers"
//     },
//     {
//       "question": "Which technology tool supports active learning?",
//       "options": ["Online discussion forums", "Pre-recorded monologues", "PDF textbooks", "Static PowerPoint slides"],
//       "answer": "Online discussion forums"
//     },
//     {
//       "question": "What does \"scaffolding\" refer to in active learning?",
//       "options": ["Providing temporary support to help students learn", "Removing all teacher guidance", "Focusing only on advanced learners", "Using only textbooks"],
//       "answer": "Providing temporary support to help students learn"
//     },
//     {
//       "question": "Which of the following is NOT a characteristic of active learning?",
//       "options": ["Student-centered", "Teacher-dominated instruction", "Collaborative", "Interactive"],
//       "answer": "Teacher-dominated instruction"
//     },
//     {
//       "question": "Role-playing in the classroom helps students:",
//       "options": ["Understand different perspectives", "Memorize facts faster", "Avoid group work", "Focus only on exams"],
//       "answer": "Understand different perspectives"
//     },
//     {
//       "question": "Which active learning technique involves summarizing key points in a visual format?",
//       "options": ["Concept mapping", "Silent reading", "Rote memorization", "Teacher monologue"],
//       "answer": "Concept mapping"
//     },
//     {
//       "question": "Why is feedback important in active learning?",
//       "options": ["It helps students improve and reflect", "It replaces assessments", "It discourages participation", "It is only given at the end of the course"],
//       "answer": "It helps students improve and reflect"
//     },
//     {
//       "question": "Which of the following best describes \"problem-based learning\"?",
//       "options": ["Students solve real-world problems to learn concepts", "Teachers deliver all content via lectures", "Focuses only on theoretical knowledge", "Avoids group discussions"],
//       "answer": "Students solve real-world problems to learn concepts"
//     },
//     {
//       "question": "What is a \"fishbowl discussion\"?",
//       "options": ["A small group discusses while others observe and then switch", "A lecture with no interaction", "A written exam", "Silent reading time"],
//       "answer": "A small group discusses while others observe and then switch"
//     },
//     {
//       "question": "Which learning style benefits most from active learning?",
//       "options": ["Only auditory learners", "All learning styles (kinesthetic, visual, auditory)", "Only visual learners", "Only read-write learners"],
//       "answer": "All learning styles (kinesthetic, visual, auditory)"
//     },
//     {
//       "question": "How does active learning affect student motivation?",
//       "options": ["Increases it through engagement", "Decreases it due to difficulty", "Has no impact", "Only helps high achievers"],
//       "answer": "Increases it through engagement"
//     },
//     {
//       "question": "Which of the following is an example of a \"low-stakes\" active learning activity?",
//       "options": ["Quick classroom polls", "Final exams", "High-pressure presentations", "Standardized tests"],
//       "answer": "Quick classroom polls"
//     },
//     {
//       "question": "What is the purpose of \"brainstorming\" in active learning?",
//       "options": ["Generate creative ideas and encourage participation", "Replace assessments", "Limit student interaction", "Focus only on teacher’s ideas"],
//       "answer": "Generate creative ideas and encourage participation"
//     },
//     {
//       "question": "Which of the following is a disadvantage of active learning?",
//       "options": ["Can be time-consuming to implement", "Reduces student engagement", "Limits critical thinking", "Only works for small classes"],
//       "answer": "Can be time-consuming to implement"
//     },
//     {
//       "question": "What is the main difference between active and passive learning?",
//       "options": ["Active learning involves participation; passive learning does not", "Passive learning is more engaging", "Active learning avoids collaboration", "Passive learning improves retention more"],
//       "answer": "Active learning involves participation; passive learning does not"
//     },
//   ],
// };
// Future<void> dataEntry() async {
//   // Reference to Firestore collection
//   final _firestore = FirebaseFirestore.instance;

//   // Creating a map where page numbers are fields
//   Map<String, dynamic> dataToStore = {};

//   for (var entry in mcqsByPage.entries) {
//     int pageNumber = entry.key;
//     List<Map<String, dynamic>> mcqs = entry.value;

//     // Store MCQs array under the page number field
//     dataToStore[pageNumber.toString()] = mcqs;
//   }

//   // Upload all pages under the 'english' document in the 'mcqs' collection
//   await _firestore
//       .collection('mcqs')
//       .doc('instructional strategies')
//       .set(dataToStore, SetOptions(merge: true));

//   print("All pages uploaded successfully.");
// }
