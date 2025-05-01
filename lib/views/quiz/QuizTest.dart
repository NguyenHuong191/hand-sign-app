import 'package:flutter/material.dart';
import 'package:hand_sign/models/Users.dart';
import 'package:hand_sign/models/question.dart';
import 'package:hand_sign/services/QuizService.dart';
import 'package:hand_sign/widgets/custom/customButton.dart';
import '../../widgets/custom/answerQuiz.dart';
import '../../widgets/custom/CustomAppBar.dart';
import '../../controllers/QuizTestController.dart';

class QuizTest extends StatefulWidget {
  final String quizId;
  final bool saveProgress;

  const QuizTest({super.key, required this.quizId, this.saveProgress = true,});

  @override
  _QuizTestState createState() => _QuizTestState();
}

class _QuizTestState extends State<QuizTest>{
  final PageController _pageController = PageController();
  final QuizService _quizService = QuizService();
  final QuizTestController _quizController = QuizTestController();

  late Future<List<Question>> _questionsFuture;
  int _currentPage = 0;
  Map<int, int> _selectedAnswer = {};
  bool _showResult = false;


  @override
  void initState() {
    super.initState();
    _questionsFuture = _quizService.fetchQuestions(widget.quizId);
  }

  void nextPage(int totalPages) {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> _checkAnswer(int selectedIndex, Question question, int questionIndex, int totalQuestions) async{
    final isCorrect = _quizController.checkAnswer(selectedIndex, question.correctAnswerIndex);
    setState(() {
      _selectedAnswer[questionIndex] = selectedIndex;
    });

    await Future.delayed(Duration(seconds: 3));

    if(_currentPage == totalQuestions -1){
      if(widget.saveProgress) {
        final userId = Users.currentUser?.id ?? 'unknown';

        await _quizController.submitQuizResult(
          quizId: widget.quizId,
          userId: userId,
          questions: await _questionsFuture,
          selectedAnswers: _selectedAnswer,
        );
      }
      setState(() {
        _showResult = true;
      });
    }else{
      nextPage(totalQuestions);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Quiz Test"),
      body: FutureBuilder<List<Question>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text("Lỗi: ${snapshot.error}"));

          final questions = snapshot.data ?? [];

          return Column(
            children: [
              Expanded(
                child:
                _showResult
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
                      SizedBox(height: 20),
                      Text("Hoàn thành bài quiz!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Builder(
                        builder: (_) {
                          final result = _quizController.calculateScore(
                            questions: questions,
                            selectedAnswers: _selectedAnswer,
                          );
                          final correctCount = result['answers']
                              .where((ans) => ans['isCorrect'] == true)
                              .length;
                          final score = result['score'];

                          return Column(
                            children: [
                              Text(
                                "${score.toStringAsFixed(1)} / 10",
                                style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Số câu đúng: $correctCount / ${questions.length}",
                                style: TextStyle(fontSize: 20),
                              ),
                              CustomButton(
                                  text: 'Quay về trang quiz ',
                                  textColor: Colors.white,
                                  gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)],
                                  onPressed: (){
                                    Navigator.pop(context);
                               }
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
                : PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final q = questions[index];

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (q.imgURL != null)
                            ClipRRect(
                              child: Image.network(
                                q.imgURL!,
                                width: 230,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 20),
                          Text(
                            q.questionText,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          ...List.generate(q.options.length, (i){
                            final isSelected = _selectedAnswer[index] == i;
                            final isCorrect = q.correctAnswerIndex == i;

                            Color btnColor = Colors.white;
                            if(_selectedAnswer.containsKey(index)){
                              if (isSelected && isCorrect) btnColor = Colors.green;
                              else if (isSelected && !isCorrect) btnColor = Colors.red;
                              else if (isCorrect) btnColor = Colors.green;
                            }
                           return Answerquiz(
                            textAnswer: q.options[i],
                            color: btnColor,
                            onPressed: _selectedAnswer.containsKey(index)
                                ? (){}
                                : () => _checkAnswer(i,q,index,questions.length),
                          );
                        })
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

