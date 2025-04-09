import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  // Singleton instance
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all courses for main screen
  Future<List<dynamic>> getCoursesArray() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('prime_essentials')
          .doc('allCourses')
          .get();

      return _extractArray(doc, 'courses');
    } catch (e) {
      print("Error fetching courses: $e");
      return [];
    }
  }

  Future<void> renameDocument(
      String collection, String oldDocId, String newDocId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the old document
    DocumentSnapshot oldDoc =
        await firestore.collection(collection).doc(oldDocId).get();

    if (oldDoc.exists) {
      // Copy data to new document
      await firestore
          .collection(collection)
          .doc(newDocId)
          .set(oldDoc.data() as Map<String, dynamic>);

      // Delete old document
      await firestore.collection(collection).doc(oldDocId).delete();
    }
  }

  Future<List<dynamic>> getCoursesByDevice(String deviceId) async {
    try {
      // Convert dotted key to underscore format
      String formattedDeviceId = formatDeviceId(deviceId);

      DocumentSnapshot doc = await _firestore
          .collection('prime_essentials')
          .doc('permissions')
          .get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the transformed deviceId exists in the document
        if (data.containsKey(formattedDeviceId) &&
            data[formattedDeviceId] is List) {
          return List<dynamic>.from(data[formattedDeviceId].map((e) {
            return {
              "courseName": e["course_name"],
              "id": e["course_id"],
            };
          }));
        }
      }

      return []; // Return empty list if deviceId not found or data is invalid
    } catch (e) {
      print("Error fetching coursess: $e");
      return []; // Return empty list on error
    }
  }

  // Get course details (chapters) based on course ID
  Future<List<dynamic>> getChaptersArray(String courseId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('courses').doc(courseId).get();

      return _extractArray(doc, 'chapters');
    } catch (e) {
      print("Error fetching chapters: $e");
      return [];
    }
  }

  // Get topics inside a course based on topicId
  Future<List<dynamic>> getTopicsArray(String courseId, String topicId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('courses').doc(courseId).get();

      return _extractArray(doc, topicId);
    } catch (e) {
      print("Error fetching topics: $e");
      return [];
    }
  }

Future<void> addOrUpdateArrayField({
  required String fieldKey,
  required List<dynamic> newValues,
}) async {
  try {
    // Format the device ID for safe Firestore usage
    String safeKey = formatDeviceId(fieldKey);

    DocumentReference docRef = FirebaseFirestore.instance
        .collection("prime_essentials")
        .doc("requests");

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Check if the device ID already exists in the data
      if (data.containsKey(safeKey) && data[safeKey] is List) {
        List<dynamic> existingValues = List.from(data[safeKey]);

        // Check if any course in the device's array already contains the same course id
        for (var existingCourse in existingValues) {
          if (existingCourse["id"] == newValues[0]["id"]) {
            // If the course is already requested for this device, throw an exception
            throw Exception("This course has already been requested for this device.");
          }
        }

        // If no duplicate is found, proceed with adding or updating the course
        existingValues.addAll(newValues);

        await docRef.update({safeKey: existingValues});
        print("Field '$safeKey' updated successfully.");
      } else {
        // If the device ID doesn't exist in the document, create it with new values
        await docRef.set({safeKey: newValues}, SetOptions(merge: true));
        print("Field '$safeKey' created successfully.");
      }
    } else {
      // If the document doesn't exist, create it with the new device ID and courses
      await docRef.set({safeKey: newValues});
      print("Field '$safeKey' created successfully.");
    }
  } catch (e) {
    print("Error updating field: $e");
    rethrow; // Rethrow the exception to propagate it further
  }
}


  // Get quiz questions based on quizId
  Future<List<dynamic>> getQuizArray(String docId, String quizId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('quiz').doc(docId).get();

      print(doc.data());
      return _extractArray(doc, quizId);
    } catch (e) {
      print("Error fetching quiz: $e");
      return [];
    }
  }

  // Extracts an array field safely from Firestore document
  List<dynamic> _extractArray(DocumentSnapshot doc, String field) {
    if (doc.exists && doc.data() != null) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey(field) && data[field] is List) {
        return List<dynamic>.from(data[field]);
      }
    }
    return [];
  }

  Future<void> isExpired({required String deviceId}) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Step 1: Clean device ID and make sure it's safe for Firestore
    String formattedDeviceId = deviceId
        .replaceAll(
            RegExp(r'[.#$\[\]/\\]'), '_') // Remove problematic Firestore chars
        .trim();

    if (formattedDeviceId.isEmpty || formattedDeviceId.length < 3) {
      print("Invalid or short device ID: '$deviceId'");
      return;
    }

    try {
      DocumentReference permissionsRef =
          _firestore.collection("prime_essentials").doc("permissions");

      DocumentSnapshot permissionsDoc = await permissionsRef.get();

      if (!permissionsDoc.exists || permissionsDoc.data() == null) {
        print("Permissions document missing.");
        return;
      }

      Map<String, dynamic> data = permissionsDoc.data() as Map<String, dynamic>;

      if (!data.containsKey(formattedDeviceId)) {
        print("Device ID not found in permissions.");
        return;
      }

      var deviceCoursesRaw = data[formattedDeviceId];

      if (deviceCoursesRaw is! List) {
        print("Invalid structure for device courses.");
        return;
      }

      List<dynamic> validCourses = [];
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);

      for (var item in deviceCoursesRaw) {
        if (item is Map<String, dynamic> && item.containsKey("expiry")) {
          try {
            String expiryStr = item["expiry"];

            // Use a safe default parser
            DateTime expiry = DateFormat("dd-MM-yy").parseStrict(expiryStr);
            DateTime expiryOnlyDate =
                DateTime(expiry.year, expiry.month, expiry.day);

            if (!expiryOnlyDate.isBefore(today)) {
              validCourses.add(item); // Keep valid
            } else {
              print("Expired course removed: $item");
            }
          } catch (e) {
            print("Date parse failed for item: $item — Error: $e");
            validCourses.add(item); // Fallback: keep it just in case
          }
        } else {
          print("Course item invalid or missing expiry: $item");
          validCourses.add(item); // Keep it
        }
      }

      // Step 3: Safely update
      await permissionsRef.update({
        formattedDeviceId:
            validCourses.isEmpty ? FieldValue.delete() : validCourses
      });

      print("Courses updated for device: $formattedDeviceId");
    } catch (e, s) {
      print("Error during isExpired for $formattedDeviceId: $e\n$s");
    }
  }

  Future<List<String>> getAllDocumentNames(String collectionName) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);
      QuerySnapshot snapshot = await collection.get();

      // Extract document IDs (names)
      List<String> documentNames = snapshot.docs.map((doc) => doc.id).toList();

      return documentNames;
    } catch (e) {
      print("Error fetching documents: $e");
      return [];
    }
  }

  Future<dynamic> getFieldFromDocument(
      String collectionName, String documentName, String fieldName) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentName)
          .get(const GetOptions(source: Source.server));

      if (docSnapshot.exists) {
        return docSnapshot.get(fieldName);
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      print("Error fetching field: $e");
      return null;
    }
  }

  String formatDeviceId(String rawId) {
    return rawId.replaceAll(RegExp(r'[.#$\[\]/\\]'), '_').trim();
  }
}
