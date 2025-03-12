class QuizQuestion {
  final String question;
  final String correct;
  final List<String> options;

  QuizQuestion({
    required this.question,
    required this.correct,
    required this.options,
  });

  // Factory method to create a QuizQuestion from a Map (useful for JSON parsing)
  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'],
      correct: map['correct'],
      options: List<String>.from(map['options']),
    );
  }

  // Convert a QuizQuestion to a Map (useful for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'correct': correct,
      'options': options,
    };
  }
}
