
import '../../../models/quiz_model.dart';

final List<Question> cprQuestions = [
  Question(
    text: "What is the recommended chest compression rate per minute for an adult during CPR?",
    options: [
      Option(text: "80–100 per minute"),
      Option(text: "100–120 per minute", isCorrect: true),
      Option(text: "120–150 per minute"),
      Option(text: "60–80 per minute"),
    ],
  ),
  Question(
    text: "What is the correct depth of chest compressions for an adult?",
    options: [
      Option(text: "1–1.5 inches"),
      Option(text: "2–2.4 inches", isCorrect: true),
      Option(text: "3–3.5 inches"),
      Option(text: "0.5–1 inch"),
    ],
  ),
  Question(
    text: "What is the first step when you find an unresponsive person?",
    options: [
      Option(text: "Start chest compressions immediately"),
      Option(text: "Check for breathing and responsiveness", isCorrect: true),
      Option(text: "Call family members"),
      Option(text: "Look for injuries"),
    ],
  ),
  Question(
    text: "What is the CPR ratio for adults when giving compressions to breaths?",
    options: [
      Option(text: "10:2"),
      Option(text: "15:2"),
      Option(text: "30:2", isCorrect: true),
      Option(text: "50:2"),
    ],
  ),
  Question(
    text: "When should you use an AED?",
    options: [
      Option(text: "Only after 10 minutes of CPR"),
      Option(text: "As soon as it becomes available", isCorrect: true),
      Option(text: "Only if the person is breathing"),
      Option(text: "Only at the hospital"),
    ],
  ),
];
