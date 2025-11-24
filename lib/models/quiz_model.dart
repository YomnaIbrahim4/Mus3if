class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, this.isCorrect = false});
}

class Question {
  final String text;
  final List<Option> options;

  Question({
    required this.text,
    required this.options,
  });
}

// The main quiz topic
class Quiz {
  final String id;
  final String title;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });
}