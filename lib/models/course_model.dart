class Course {
  final String courseName;
  final String id;

  Course({required this.courseName, required this.id});

  // Factory constructor to create a Course from a Map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseName: json['courseName'],
      id: json['id'],
    );
  }

  // Convert Course object to Map
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'id': id,
    };
  }
}
