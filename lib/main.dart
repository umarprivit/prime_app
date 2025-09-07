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
  await dataEntry();
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
  48: [
    {
      "question": "What is the main raw material for the Haber process?",
      "options": ["Ammonia", "Hydrogen", "Nitrogen", "Oxygen"],
      "answer": "Nitrogen"
    },
    {
      "question": "Which gas is fixed in the Haber process?",
      "options": ["Hydrogen", "Oxygen", "Nitrogen", "Ammonia"],
      "answer": "Nitrogen"
    },
    {
      "question": "What is the primary product of the Contact process?",
      "options": [
        "Phosphoric acid",
        "Hydrochloric acid",
        "Sulfuric acid",
        "Nitric acid"
      ],
      "answer": "Sulfuric acid"
    },
    {
      "question": "Which catalyst is used in the Haber process?",
      "options": ["Nickel", "Vanadium pentoxide", "Iron", "Platinum"],
      "answer": "Iron"
    },
    {
      "question": "What is the main use of ammonia produced industrially?",
      "options": ["Explosives", "Fuel", "Fertilizer", "Cleaning agent"],
      "answer": "Fertilizer"
    },
    {
      "question": "What are plastics primarily made from?",
      "options": ["Fibers", "Ceramics", "Polymers", "Metals"],
      "answer": "Polymers"
    },
    {
      "question": "Which plastic is commonly used for making bottles?",
      "options": [
        "Polyethylene terephthalate",
        "Polystyrene",
        "Polyvinyl chloride",
        "Polypropylene"
      ],
      "answer": "Polyethylene terephthalate"
    },
    {
      "question": "What type of reaction is polymerization?",
      "options": ["Addition", "Substitution", "Combination", "Decomposition"],
      "answer": "Addition"
    },
    {
      "question": "What is a major environmental concern related to plastics?",
      "options": [
        "Water pollution",
        "Recycling difficulty",
        "Biodegradability",
        "Toxicity"
      ],
      "answer": "Water pollution"
    },
    {
      "question": "Which fertilizer is known as a nitrogenous fertilizer?",
      "options": ["Calcium nitrate", "Potash", "Urea", "Superphosphate"],
      "answer": "Urea"
    },
    {
      "question": "Which element is essential in NPK fertilizers?",
      "options": ["Potassium", "Phosphorus", "Nitrogen", "Sodium"],
      "answer": "Nitrogen"
    },
    {
      "question": "What is the primary source of phosphates for fertilizers?",
      "options": ["Sulfates", "Nitrate salts", "Rock phosphate", "Ammonia"],
      "answer": "Rock phosphate"
    },
    {
      "question": "Which process is used to manufacture sulfuric acid?",
      "options": ["Solvay", "Contact", "Ostwald", "Haber"],
      "answer": "Contact"
    },
    {
      "question":
          "What is the environmental impact of excessive fertilizer use?",
      "options": [
        "Noise pollution",
        "Soil erosion",
        "Water pollution",
        "Air pollution"
      ],
      "answer": "Water pollution"
    },
    {
      "question": "Which industry produces penicillin?",
      "options": ["Agriculture", "Petrochemical", "Pharmaceutical", "Textile"],
      "answer": "Pharmaceutical"
    },
    {
      "question": "What is the function of a catalyst in industrial reactions?",
      "options": [
        "Provide reactants",
        "Slow down reaction",
        "Speed up reaction",
        "Absorb heat"
      ],
      "answer": "Speed up reaction"
    },
    {
      "question": "Which fuel is considered the cleanest fossil fuel?",
      "options": ["Diesel", "Petroleum", "Natural gas", "Coal"],
      "answer": "Natural gas"
    },
    {
      "question": "What is a sustainable practice in industry?",
      "options": [
        "Ignoring safety",
        "Overusing resources",
        "Reducing pollution",
        "Increasing waste"
      ],
      "answer": "Reducing pollution"
    },
    {
      "question": "Which gas is reduced in the Ostwald process?",
      "options": ["Carbon dioxide", "Oxygen", "Ammonia", "Nitrogen"],
      "answer": "Ammonia"
    },
    {
      "question": "What is biogas mainly composed of?",
      "options": ["Nitrogen", "Hydrogen", "Methane", "Carbon dioxide"],
      "answer": "Methane"
    }
  ],
  49: [
    {
      "question": "Which is a biodegradable plastic?",
      "options": [
        "Polystyrene",
        "Polyvinyl chloride",
        "Polylactic acid",
        "Polyethylene"
      ],
      "answer": "Polylactic acid"
    },
    {
      "question": "What is the major cause of acid rain?",
      "options": [
        "Methane",
        "Sulfur dioxide",
        "Nitrogen oxide",
        "Carbon dioxide"
      ],
      "answer": "Sulfur dioxide"
    },
    {
      "question":
          "What is a primary raw material for the petrochemical industry?",
      "options": ["Limestone", "Natural gas", "Crude oil", "Coal"],
      "answer": "Crude oil"
    },
    {
      "question": "Which fertilizer improves soil potassium content?",
      "options": ["Superphosphate", "Potash", "Urea", "Ammonium nitrate"],
      "answer": "Potash"
    },
    {
      "question": "Which polymer is used to make synthetic fibers?",
      "options": ["Polyvinyl chloride", "Nylon", "Polyethylene", "Polystyrene"],
      "answer": "Nylon"
    },
    {
      "question": "What is the main pollutant released by factories?",
      "options": ["Oxygen", "Sulfur dioxide", "Methane", "Carbon monoxide"],
      "answer": "Sulfur dioxide"
    },
    {
      "question": "Which process is used to produce lime in industry?",
      "options": [
        "Calcination",
        "Fermentation",
        "Distillation",
        "Electrolysis"
      ],
      "answer": "Calcination"
    },
    {
      "question": "What is the main purpose of green chemistry?",
      "options": [
        "Promote pollution",
        "Increase cost",
        "Reduce environmental impact",
        "Increase waste"
      ],
      "answer": "Reduce environmental impact"
    },
    {
      "question":
          "Which fertilizer is commonly derived from ammonia and nitric acid?",
      "options": ["Potash", "Superphosphate", "Ammonium nitrate", "Urea"],
      "answer": "Ammonium nitrate"
    },
    {
      "question": "What is a major challenge in the pharmaceutical industry?",
      "options": [
        "Packaging",
        "Drug efficacy",
        "Environmental pollution",
        "Cost of raw materials"
      ],
      "answer": "Drug efficacy"
    },
    {
      "question": "What kind of reaction is involved in soap production?",
      "options": [
        "Hydrolysis",
        "Neutralization",
        "Saponification",
        "Polymerization"
      ],
      "answer": "Saponification"
    },
    {
      "question": "Which is a natural polymer?",
      "options": ["Polyethylene", "Polyester", "Cellulose", "Nylon"],
      "answer": "Cellulose"
    },
    {
      "question":
          "Which industrial process converts crude oil into useful products?",
      "options": ["Extraction", "Fermentation", "Refining", "Polymerization"],
      "answer": "Refining"
    },
    {
      "question": "What is the role of surfactants in detergents?",
      "options": [
        "Produce foam",
        "Increase viscosity",
        "Remove grease",
        "Soften water"
      ],
      "answer": "Remove grease"
    },
    {
      "question": "What is the chemical formula of urea?",
      "options": ["CH3NO2", "NH4NO3", "CO(NH2)2", "CH4N2O"],
      "answer": "CO(NH2)2"
    },
    {
      "question":
          "Which metal is commonly used as a catalyst in hydrogenation?",
      "options": ["Zinc", "Copper", "Nickel", "Iron"],
      "answer": "Nickel"
    },
    {
      "question": "Which gas is released during fermentation?",
      "options": ["Methane", "Nitrogen", "Carbon dioxide", "Oxygen"],
      "answer": "Carbon dioxide"
    },
    {
      "question":
          "What is a key principle of sustainable industrial development?",
      "options": [
        "Increase emissions",
        "Ignore pollution",
        "Minimize waste",
        "Maximize resource use"
      ],
      "answer": "Minimize waste"
    },
    {
      "question": "What is a plasticizer used for?",
      "options": [
        "Making plastic brittle",
        "Coloring plastic",
        "Softening plastic",
        "Hardening plastic"
      ],
      "answer": "Softening plastic"
    },
    {
      "question": "Which industry uses the Solvay process?",
      "options": [
        "Pharmaceutical",
        "Plastic",
        "Soda ash production",
        "Fertilizer"
      ],
      "answer": "Soda ash production"
    }
  ],
  50: [
    {
      "question":
          "What is the environmental impact of chlorofluorocarbons (CFCs)?",
      "options": [
        "Smog",
        "Acid rain",
        "Ozone layer depletion",
        "Global warming"
      ],
      "answer": "Ozone layer depletion"
    },
    {
      "question": "Which gas is involved in photochemical smog formation?",
      "options": [
        "Sulfur dioxide",
        "Oxygen",
        "Nitrogen dioxide",
        "Carbon monoxide"
      ],
      "answer": "Nitrogen dioxide"
    },
    {
      "question": "What is the main raw material for nylon production?",
      "options": ["Benzene", "Propylene", "Caprolactam", "Ethylene"],
      "answer": "Caprolactam"
    },
    {
      "question": "Which polymer is used for making water bottles?",
      "options": [
        "Polypropylene",
        "Polyvinyl chloride",
        "Polyethylene terephthalate",
        "Polystyrene"
      ],
      "answer": "Polyethylene terephthalate"
    },
    {
      "question": "What is the effect of heavy metals in industrial waste?",
      "options": [
        "Oxygenation",
        "Soil fertility",
        "Toxicity",
        "Water purification"
      ],
      "answer": "Toxicity"
    },
    {
      "question": "Which process removes sulfur compounds from petroleum?",
      "options": [
        "Distillation",
        "Reforming",
        "Hydrodesulfurization",
        "Cracking"
      ],
      "answer": "Hydrodesulfurization"
    },
    {
      "question": "What is a biofertilizer?",
      "options": [
        "Mineral fertilizer",
        "Synthetic fertilizer",
        "Microbial fertilizer",
        "Chemical fertilizer"
      ],
      "answer": "Microbial fertilizer"
    },
    {
      "question": "Which gas contributes to the greenhouse effect?",
      "options": ["Argon", "Oxygen", "Carbon dioxide", "Nitrogen"],
      "answer": "Carbon dioxide"
    },
    {
      "question": "What is the main use of plastics in industry?",
      "options": ["Catalysts", "Fertilizers", "Packaging", "Fuel"],
      "answer": "Packaging"
    },
    {
      "question": "Which pharmaceutical is used as an analgesic?",
      "options": ["Paracetamol", "Insulin", "Aspirin", "Penicillin"],
      "answer": "Paracetamol"
    }
  ]
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
      .doc('chemistry')
      .set(dataToStore, SetOptions(merge: true));

  print("All pages uploaded successfully.");
}
