import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<dynamic>> getCoursesByDevice(String deviceId) async {
    try {
      // Convert dotted key to underscore format
      String formattedDeviceId = deviceId.replaceAll('.', '_');

      DocumentSnapshot doc = await _firestore
          .collection('prime_essentials')
          .doc('permissions')
          .get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the transformed deviceId exists in the document
        if (data.containsKey(formattedDeviceId) &&
            data[formattedDeviceId] is List) {
          print("here it is okay");
          return List<dynamic>.from(data[formattedDeviceId].map((e) {
            return e['course_id'];
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
      // Replace special characters to avoid Firestore issues
      String safeKey = fieldKey.replaceAll('.', '_');

      DocumentReference docRef = FirebaseFirestore.instance
          .collection("prime_essentials")
          .doc("requests");

      DocumentSnapshot doc = await docRef.get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data.containsKey(safeKey) && data[safeKey] is List) {
          // If field exists, merge old and new values without duplicates
          List<dynamic> updatedValues = List.from(data[safeKey]);

          for (var value in newValues) {
            if (!updatedValues.contains(value)) {
              updatedValues.add(value);
            }
          }

          await docRef.update({safeKey: updatedValues});
        } else {
          // If field does not exist, create it with new values
          await docRef.set({safeKey: newValues}, SetOptions(merge: true));
        }
      } else {
        // If document does not exist, create it with the new field
        await docRef.set({safeKey: newValues});
      }

      print("Field '$safeKey' updated successfully.");
    } catch (e) {
      print("Error updating field: $e");
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
    String formattedDeviceId = deviceId.replaceAll('.', '_');
    try {
      DocumentReference permissionsRef =
          _firestore.collection("prime_essentials").doc("permissions");

      DocumentSnapshot permissionsDoc = await permissionsRef.get();

      if (permissionsDoc.exists && permissionsDoc.data() != null) {
        Map<String, dynamic> permissionsData =
            permissionsDoc.data() as Map<String, dynamic>;

        if (permissionsData.containsKey(formattedDeviceId) &&
            permissionsData[formattedDeviceId] is List) {
          List<dynamic> courses = List.from(permissionsData[formattedDeviceId]);

          // Get today's date
          DateTime today = DateTime.now();

          // Remove expired courses
          courses.removeWhere((course) {
            String expiryString = course["expiry"];
            try {
              DateTime expiryDate = DateFormat("dd-MM-yy").parse(expiryString);
              return expiryDate.isBefore(today); // Remove if expired
            } catch (e) {
              print("Invalid date format: $expiryString");
              return false;
            }
          });

          if (courses.isEmpty) {
            // If no courses remain, delete the deviceId entry
            await permissionsRef
                .update({formattedDeviceId: FieldValue.delete()});
          } else {
            // Update Firestore with remaining courses
            await permissionsRef.update({formattedDeviceId: courses});
          }

          print("Expired courses removed successfully.");
        } else {
          print("No courses found for device ID: $formattedDeviceId.");
        }
      } else {
        print("Permissions document does not exist.");
      }
    } catch (e) {
      print("Error: $e");
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
}
