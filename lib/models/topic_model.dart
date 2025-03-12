class Topic {
  final String topicName;
  final String id;
  final String link;
  final String quizId;

  Topic(
      {required this.topicName,
      required this.id,
      required this.link,
      required this.quizId});

  // Factory method to create a Topic object from JSON
  factory Topic.fromJson(Map<dynamic, dynamic> json) {
    return Topic(
        topicName: json['topicName'] as String ?? "Unknown Topic",
        id: json['id'] as String ?? "Unknown ID",
        quizId: json['quizId'] ?? "none",
        link: json['link'] ?? "none");
  }

  // Convert a Topic object to JSON
  Map<String, dynamic> toJson() {
    return {'topicName': topicName, 'id': id, 'link': link, 'quizId': quizId};
  }
}
