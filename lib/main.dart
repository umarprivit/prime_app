import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
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

Map<int, List<Map<String, dynamic>>> mcqsByPage = {
  5: [
    {
      "question": "Rasheed said, 'What a fantastic performance!'",
      "options": [
        "Rasheed exclaimed what a fantastic performance it was.",
        "Rasheed exclaimed how fantastic the performance was.",
        "Rasheed said that it was a fantastic performance.",
        "Rasheed exclaimed that it was a fantastic performance."
      ],
      "answer": "Rasheed exclaimed what a fantastic performance it was."
    },
    {
      "question":
          "The teacher exclaimed, 'How well you have done on the test, Rasheed!'",
      "options": [
        "The teacher exclaimed how well Rasheed has done on the test.",
        "The teacher exclaimed that Rasheed had done well on the test.",
        "The teacher exclaimed how well Rasheed had done on the test.",
        "The teacher exclaimed how well Rasheed does on the test."
      ],
      "answer": "The teacher exclaimed how well Rasheed had done on the test."
    },
    {
      "question": "Rasheed said, 'What a beautiful garden this is!'",
      "options": [
        "Rasheed said that it was a beautiful garden.",
        "Rasheed exclaimed that it was a beautiful garden.",
        "Rasheed exclaimed what a beautiful garden it was.",
        "Rasheed said what a beautiful garden this is."
      ],
      "answer": "Rasheed exclaimed what a beautiful garden it was."
    },
    {
      "question":
          "The teacher said, 'How smartly Rasheed answers the questions!'",
      "options": [
        "The teacher exclaimed how smartly Rasheed answers the questions.",
        "The teacher exclaimed how smartly Rasheed answered the questions.",
        "The teacher said that Rasheed answers the questions smartly.",
        "The teacher said that Rasheed answered the questions smartly."
      ],
      "answer":
          "The teacher exclaimed how smartly Rasheed answered the questions."
    },
    {
      "question": "Rasheed exclaimed, 'How exciting this adventure is!'",
      "options": [
        "Rasheed exclaimed that this adventure was exciting.",
        "Rasheed exclaimed how exciting this adventure is.",
        "Rasheed exclaimed how exciting that adventure was.",
        "Rasheed exclaimed how exciting this adventure was."
      ],
      "answer": "Rasheed exclaimed how exciting this adventure was."
    },
    {
      "question": "The teacher said, 'What a talented student Rasheed is!'",
      "options": [
        "The teacher exclaimed that Rasheed was a talented student.",
        "The teacher said what a talented student Rasheed is.",
        "The teacher exclaimed that Rasheed is a talented student.",
        "The teacher exclaimed what a talented student Rasheed was."
      ],
      "answer": "The teacher exclaimed that Rasheed is a talented student."
    },
    {
      "question": "Rasheed said, 'How amazing the view is from here!'",
      "options": [
        "Rasheed said how amazing the view was from there.",
        "Rasheed exclaimed how amazing the view is from there.",
        "Rasheed exclaimed how amazing the view was from here.",
        "Rasheed said how amazing the view is from here."
      ],
      "answer": "Rasheed exclaimed how amazing the view was from here."
    },
    {
      "question": "The teacher said, 'What a great effort Rasheed has made!'",
      "options": [
        "The teacher exclaimed that Rasheed made a great effort.",
        "The teacher said that Rasheed had made a great effort.",
        "The teacher exclaimed what a great effort Rasheed had made.",
        "The teacher exclaimed what a great effort Rasheed has made."
      ],
      "answer": "The teacher exclaimed what a great effort Rasheed had made."
    },
    {
      "question": "Rasheed exclaimed, 'What a wonderful opportunity this is!'",
      "options": [
        "Rasheed exclaimed that it was a wonderful opportunity.",
        "Rasheed exclaimed what a wonderful opportunity it is.",
        "Rasheed exclaimed what a wonderful opportunity it was.",
        "Rasheed said that it was a wonderful opportunity."
      ],
      "answer": "Rasheed exclaimed what a wonderful opportunity it was."
    },
    {
      "question":
          "The teacher exclaimed, 'How well Rasheed performed in the competition!'",
      "options": [
        "The teacher exclaimed how well Rasheed performed in the competition.",
        "The teacher said that Rasheed had performed well in the competition.",
        "The teacher exclaimed that Rasheed performed well in the competition.",
        "The teacher exclaimed how well Rasheed had performed in the competition."
      ],
      "answer":
          "The teacher exclaimed how well Rasheed had performed in the competition."
    }
  ],
//   4: [
//   {
//     "question": "She said, \"What a beautiful day it is!\"",
//     "options": [
//       "She exclaimed that it is a beautiful day.",
//       "She exclaimed that it was a beautiful day.",
//       "She exclaimed what a beautiful day it is.",
//       "She exclaimed what a beautiful day it was."
//     ],
//     "answer": "She exclaimed that it was a beautiful day."
//   },
//   {
//     "question": "He exclaimed, \"How clever you are!\"",
//     "options": [
//       "He exclaimed how clever he was.",
//       "He exclaimed how clever you are.",
//       "He exclaimed how clever you were.",
//       "He exclaimed that you are clever."
//     ],
//     "answer": "He exclaimed how clever you were."
//   },
//   {
//     "question": "They said, \"What a wonderful performance!\"",
//     "options": [
//       "They said that it was a wonderful performance.",
//       "They said what a wonderful performance it was.",
//       "They exclaimed what a wonderful performance it was.",
//       "They exclaimed that it was a wonderful performance."
//     ],
//     "answer": "They exclaimed what a wonderful performance it was."
//   },
//   {
//     "question": "She cried, \"Oh, how I wish I could go!\"",
//     "options": [
//       "She cried how she wished she could go.",
//       "She exclaimed how she wished she could go.",
//       "She exclaimed that she wished she could go.",
//       "She exclaimed that she wishes she could go."
//     ],
//     "answer": "She exclaimed that she wished she could go."
//   },
//   {
//     "question": "He shouted, \"How difficult the exam was!\"",
//     "options": [
//       "He shouted how difficult the exam was.",
//       "He shouted that the exam was difficult.",
//       "He exclaimed how difficult the exam was.",
//       "He exclaimed that the exam was difficult."
//     ],
//     "answer": "He exclaimed how difficult the exam was."
//   },
//   {
//     "question": "She said, \"What a terrible mistake I made!\"",
//     "options": [
//       "She said that she made a terrible mistake.",
//       "She exclaimed that she had made a terrible mistake.",
//       "She exclaimed what a terrible mistake she made.",
//       "She exclaimed what a terrible mistake she had made."
//     ],
//     "answer": "She exclaimed what a terrible mistake she had made."
//   },
//   {
//     "question": "He exclaimed, \"How amazing this place is!\"",
//     "options": [
//       "He exclaimed how amazing this place was.",
//       "He exclaimed that this place is amazing.",
//       "He exclaimed that this place was amazing.",
//       "He exclaimed how amazing this place is."
//     ],
//     "answer": "He exclaimed that this place was amazing."
//   },
//   {
//     "question": "She said, \"What a lovely dress you are wearing!\"",
//     "options": [
//       "She exclaimed that she was wearing a lovely dress.",
//       "She exclaimed that you are wearing a lovely dress.",
//       "She said that you were wearing a lovely dress.",
//       "She exclaimed that you were wearing a lovely dress."
//     ],
//     "answer": "She exclaimed that you were wearing a lovely dress."
//   },
//   {
//     "question": "He exclaimed, \"How quickly the time flies!\"",
//     "options": [
//       "He exclaimed that the time flies quickly.",
//       "He exclaimed how quickly the time flew.",
//       "He exclaimed how quickly the time flies.",
//       "He exclaimed how quickly the time had flown."
//     ],
//     "answer": "He exclaimed how quickly the time flew."
//   },
//   {
//     "question": "She said, \"Oh, what a beautiful painting!\"",
//     "options": [
//       "She exclaimed that it was a beautiful painting.",
//       "She said that it was a beautiful painting.",
//       "She exclaimed that it is a beautiful painting.",
//       "She exclaimed what a beautiful painting it was."
//     ],
//     "answer": "She exclaimed what a beautiful painting it was."
//   },
//   {
//     "question": "They said, \"How sweet the song is!\"",
//     "options": [
//       "They exclaimed how sweet the song was.",
//       "They exclaimed how sweet the song is.",
//       "They said how sweet the song was.",
//       "They said how sweet the song is."
//     ],
//     "answer": "They exclaimed how sweet the song was."
//   },
//   {
//     "question": "John said, \"What an interesting movie this is!\"",
//     "options": [
//       "John said that it was an interesting movie.",
//       "John said that it is an interesting movie.",
//       "John exclaimed what an interesting movie it was.",
//       "John exclaimed what an interesting movie it is."
//     ],
//     "answer": "John exclaimed what an interesting movie it was."
//   },
//   {
//     "question": "She said, \"How bright the stars are tonight!\"",
//     "options": [
//       "She exclaimed that the stars are bright tonight.",
//       "She exclaimed that the stars were bright tonight.",
//       "She exclaimed how bright the stars were tonight.",
//       "She exclaimed how bright the stars are tonight."
//     ],
//     "answer": "She exclaimed how bright the stars were tonight."
//   },
//   {
//     "question": "He shouted, \"What a beautiful sunrise!\"",
//     "options": [
//       "He shouted that it was a beautiful sunrise.",
//       "He shouted what a beautiful sunrise it was.",
//       "He exclaimed that it was a beautiful sunrise.",
//       "He exclaimed what a beautiful sunrise it was."
//     ],
//     "answer": "He exclaimed what a beautiful sunrise it was."
//   },
//   {
//     "question": "She exclaimed, \"How fast you run!\"",
//     "options": [
//       "She exclaimed how fast you run.",
//       "She exclaimed how fast you ran.",
//       "She exclaimed how fast you had run.",
//       "She exclaimed that you run fast."
//     ],
//     "answer": "She exclaimed how fast you ran."
//   },
//   {
//     "question": "He exclaimed, \"What a surprise it is!\"",
//     "options": [
//       "He exclaimed that it was a surprise.",
//       "He exclaimed what a surprise it was.",
//       "He exclaimed what a surprise it is.",
//       "He exclaimed that it is a surprise."
//     ],
//     "answer": "He exclaimed what a surprise it was."
//   },
//   {
//     "question": "They said, \"How well she sings!\"",
//     "options": [
//       "They exclaimed how well she sings.",
//       "They exclaimed how well she sang.",
//       "They said how well she sings.",
//       "They said how well she sang."
//     ],
//     "answer": "They exclaimed how well she sang."
//   },
//   {
//     "question": "He shouted, \"What an exciting game this is!\"",
//     "options": [
//       "He shouted that it is an exciting game.",
//       "He shouted that it was an exciting game.",
//       "He exclaimed what an exciting game it was.",
//       "He exclaimed what an exciting game it is."
//     ],
//     "answer": "He exclaimed what an exciting game it was."
//   },
//   {
//     "question": "She said, \"How wonderful to see you!\"",
//     "options": [
//       "She exclaimed how wonderful it was to see you.",
//       "She said how wonderful to see you.",
//       "She exclaimed how wonderful it is to see you.",
//       "She exclaimed that it was wonderful to see you."
//     ],
//     "answer": "She exclaimed how wonderful it was to see you."
//   },
//   {
//     "question": "They exclaimed, \"What a lovely morning!\"",
//     "options": [
//       "They exclaimed what a lovely morning it is.",
//       "They exclaimed what a lovely morning it was.",
//       "They exclaimed that it is a lovely morning.",
//       "They exclaimed that it was a lovely morning."
//     ],
//     "answer": "They exclaimed what a lovely morning it was."
//   }
// ]
};

Future<void> dataEntry() async {
  // Reference to Firestore collection
  final _firestore = FirebaseFirestore.instance;

  // Creating a map where page numbers are fields
  Map<String, dynamic> dataToStore = {};

  for (var entry in mcqsByPage.entries) {
    int pageNumber = entry.key;
    List<Map<String, dynamic>> mcqs = entry.value;

    // Store MCQs array under the page number field
    dataToStore[pageNumber.toString()] = mcqs;
  }

  // Upload all pages under the 'english' document in the 'mcqs' collection
  await _firestore
      .collection('mcqs')
      .doc('narration')
      .set(dataToStore, SetOptions(merge: true));

  print("All pages uploaded successfully.");
}
