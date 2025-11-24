
import '../../../models/quiz_model.dart';

final List<Question> chokingQuestions = [
  Question(
    text: "What is the universal sign of choking?",
    options: [
      Option(text: "Crying loudly"),
      Option(text: "Hands clutching the throat", isCorrect: true),
      Option(text: "Coughing strongly"),
      Option(text: "Rubbing the chest"),
    ],
  ),
  Question(
    text: "If a person is choking but can still cough, what should you do?",
    options: [
      Option(text: "Start abdominal thrusts"),
      Option(text: "Encourage them to keep coughing", isCorrect: true),
      Option(text: "Hit their back repeatedly"),
      Option(text: "Lay them on the ground"),
    ],
  ),
  Question(
    text: "For a conscious adult choking severely, what should you perform?",
    options: [
      Option(text: "CPR"),
      Option(text: "Abdominal thrusts (Heimlich maneuver)", isCorrect: true),
      Option(text: "Put water in their mouth"),
      Option(text: "Lay them down"),
    ],
  ),
  Question(
    text: "What should you do if a choking victim becomes unconscious?",
    options: [
      Option(text: "Start CPR immediately", isCorrect: true),
      Option(text: "Give back blows only"),
      Option(text: "Give them water"),
      Option(text: "Wait for help"),
    ],
  ),
  Question(
    text: "Back blows should be delivered between the:",
    options: [
      Option(text: "Lower back"),
      Option(text: "Shoulder blades", isCorrect: true),
      Option(text: "Neck area"),
      Option(text: "Lower ribs"),
    ],
  ),
];
