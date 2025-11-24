import '../../models/quiz_model.dart';
import 'questions_sample/bleeding_questions.dart';
import 'questions_sample/burns_questions.dart';
import 'questions_sample/choking_questions.dart';
import 'questions_sample/cpr_questions.dart';

enum QuizStatus {
  completed,
  inProgress,
  notStarted,
}

final List<Map<String, dynamic>> mockQuizzes = [
  {
    'title': 'CPR',
    // 'progress': 1.0,
    // 'status': QuizStatus.completed,
  },
  {
    'title': 'Bleeding and Wounds',
    // 'progress': 0.75,
    // 'status': QuizStatus.inProgress,
  },
  {
    'title': 'Burns and Scalds',
    // 'progress': 0.0,
    // 'status': QuizStatus.notStarted,
  },
  {
    'title': 'Choking',
    // 'progress': 0.0,
    // 'status': QuizStatus.notStarted,
  },
];

// quiz questions mapping
final Map<String, List<Question>> quizQuestionsMap = {
  'CPR': cprQuestions,
  'Bleeding and Wounds': bleedingQuestions,
  'Burns and Scalds': burnsQuestions,
  'Choking': chokingQuestions,
};
