import 'package:flutter/material.dart';
import '../../common/custom/QuizItem.dart';
import '../../common/custom/CustomAppBar.dart';
import './QuizTest.dart'; // Đảm bảo đường dẫn đúng

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizScreen(),
  ));
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> quizData = [
    {"title": "Quiz 1", "score": 90, "color": Colors.lightBlue.shade100},
    {"title": "Quiz 2", "score": 100, "color": Colors.pink.shade100},
    {"title": "Quiz 3", "score": 0, "color": Colors.red.shade100},
    {"title": "Quiz 4", "score": 0, "color": Colors.purple.shade100},
    {"title": "Quiz 5", "score": 20, "color": Colors.green.shade100}, // Sửa Quiz 4 -> Quiz 5
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Quiz Test"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: quizData.length,
          itemBuilder: (context, index) {
            final quiz = quizData[index];
            return QuizItem(
              title: quiz["title"],
              score: quiz["score"],
              color: quiz["color"],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizTest()), // Chuyển trang
                );
              },
            );
          },
        ),
      ),
    );
  }
}
