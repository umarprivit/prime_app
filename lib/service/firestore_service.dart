import 'package:cloud_firestore/cloud_firestore.dart';

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
          return List<dynamic>.from(
              data[formattedDeviceId]); // Return the array
        }
      }

      return []; // Return empty list if deviceId not found or data is invalid
    } catch (e) {
      print("Error fetching courses: $e");
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

      return _extractArray(doc, "quiz1");
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
}
