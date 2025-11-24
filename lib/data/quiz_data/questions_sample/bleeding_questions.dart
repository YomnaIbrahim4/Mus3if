
import '../../../models/quiz_model.dart';

final List<Question> bleedingQuestions = [
  Question(
    text: "What is the first step to control external bleeding?",
    options: [
      Option(text: "Wash the wound with soap"),
      Option(text: "Apply direct pressure", isCorrect: true),
      Option(text: "Apply ointment"),
      Option(text: "Elevate the legs"),
    ],
  ),
  Question(
    text: "What should you do if blood soaks through a bandage?",
    options: [
      Option(text: "Remove the bandage immediately"),
      Option(text: "Add more layers on top", isCorrect: true),
      Option(text: "Wash the wound again"),
      Option(text: "Use cold water"),
    ],
  ),
  Question(
    text: "Which type of bleeding is the most dangerous?",
    options: [
      Option(text: "Capillary bleeding"),
      Option(text: "Venous bleeding"),
      Option(text: "Arterial bleeding", isCorrect: true),
      Option(text: "Skin bleeding"),
    ],
  ),
  Question(
    text: "How do you treat a nosebleed?",
    options: [
      Option(text: "Lean the person backward"),
      Option(text: "Lean forward and pinch the nose", isCorrect: true),
      Option(text: "Lie the person down"),
      Option(text: "Put tissue inside the nostril"),
    ],
  ),
  Question(
    text: "When should you apply a tourniquet?",
    options: [
      Option(text: "For minor cuts"),
      Option(text: "Only if direct pressure fails", isCorrect: true),
      Option(text: "For nosebleeds"),
      Option(text: "For bruises"),
    ],
  ),
];
