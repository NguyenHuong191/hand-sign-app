
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hand_sign/models/quiz.dart';
import 'package:hand_sign/services/QuizService.dart';

class QuizListController {
  final QuizService _quizService = QuizService();

  Future<List<Quiz>> fetchAllQuiz() async{
    return await _quizService.getAllQuiz();
  }

  Future<List<String>> getQuizTypes() async {
    final allQuizzes = await fetchAllQuiz();
    final types = allQuizzes
        .map((quiz) => quiz.typeOfQuiz)
        .where((type) => type != null && type.trim().isNotEmpty)
        .toSet()
        .toList();
    return types;
  }

}