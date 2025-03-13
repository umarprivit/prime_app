class Topic {
  final String topicName;
  final String id;
  final String link;

  Topic({required this.topicName, required this.id, required this.link});

  // Factory method to create a Topic object from JSON
  factory Topic.fromJson(Map<dynamic, dynamic> json) {
    return Topic(
        topicName: json['topicName'] as String ?? "Unknown Topic",
        id: json['id'] as String ?? "Unknown ID",
        link: json['link'] ?? "none");
  }

  // Convert a Topic object to JSON
  Map<String, dynamic> toJson() {
    return {
      'topicName': topicName,
      'id': id,
      'link': link,
    };
  }
}
