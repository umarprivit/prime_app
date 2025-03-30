class Course {
  final String courseName;
  final String id;
  String? price;
  String? demoURL;

  Course({required this.courseName, required this.id, this.price, this.demoURL});

  // Factory constructor to create a Course from a Map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseName: json['courseName'],
      id: json['id'],
      price: json['price'] ?? "0",
      demoURL: json['demoURL'] ?? "",
    );
  }

  // Convert Course object to Map
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'id': id,
      'price': price,
      'demoURL': demoURL,
    };
  }
}
