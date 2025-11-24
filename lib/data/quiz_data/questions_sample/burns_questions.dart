
import '../../../models/quiz_model.dart';

final List<Question> burnsQuestions = [
  Question(
    text: "What is the first step in treating a minor burn?",
    options: [
      Option(text: "Apply toothpaste"),
      Option(text: "Cool the burn under running water", isCorrect: true),
      Option(text: "Apply butter"),
      Option(text: "Cover with cotton"),
    ],
  ),
  Question(
    text: "Which burn affects the epidermis only?",
    options: [
      Option(text: "Third-degree burn"),
      Option(text: "First-degree burn", isCorrect: true),
      Option(text: "Second-degree burn"),
      Option(text: "Deep-tissue burn"),
    ],
  ),
  Question(
    text: "What should you never do with a severe burn?",
    options: [
      Option(text: "Cover it loosely"),
      Option(text: "Apply ice directly", isCorrect: true),
      Option(text: "Call emergency services"),
      Option(text: "Protect from infection"),
    ],
  ),
  Question(
    text: "Signs of a second-degree burn include:",
    options: [
      Option(text: "Red skin with no pain"),
      Option(text: "Blisters and severe pain", isCorrect: true),
      Option(text: "Charred skin"),
      Option(text: "No swelling"),
    ],
  ),
  Question(
    text: "Why should jewelry be removed from a burned area?",
    options: [
      Option(text: "To reduce infection"),
      Option(text: "Because swelling will occur", isCorrect: true),
      Option(text: "To prevent blisters"),
      Option(text: "To cool the area faster"),
    ],
  ),
];
