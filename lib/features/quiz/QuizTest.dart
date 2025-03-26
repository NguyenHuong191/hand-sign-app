import 'package:flutter/material.dart';
import '../../common/custom/answerQuiz.dart';
import '../../common/custom/CustomAppBar.dart';

class QuizTest extends StatefulWidget {
  @override
  _QuizTestState createState() => _QuizTestState();
}

class _QuizTestState extends State<QuizTest>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Quiz Test"),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hình ảnh hoặc video
            ClipRRect(
              child: Image.asset(
                  "assets/images/quiz_img_test.jfif",
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "What does it mean ?",
              style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Answerquiz(
                textAnswer: "Love",
                color: Colors.white,
                onPressed: (){

                }
            ),
            Answerquiz(
                textAnswer: "Hi",
                color: Colors.white,
                onPressed: (){

                }
            ),
            Answerquiz(
                textAnswer: "Red",
                color: Colors.white,
                onPressed: (){

                }
            ),
            Answerquiz(
                textAnswer: "Nice to meet you",
                color: Colors.white,
                onPressed: (){

                }
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.green, size: 35),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green, size: 35),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}

