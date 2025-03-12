class Chapter {
  final String chapterName;
  final String id;

  Chapter({required this.chapterName, required this.id});

  // Factory method to create a Chapter object from JSON
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterName: json['chapterName'] as String,
      id: json['id'] as String,
    );
  }

  // Convert a Chapter object to JSON
  Map<String, dynamic> toJson() {
    return {
      'chapterName': chapterName,
      'id': id,
    };
  }
}
