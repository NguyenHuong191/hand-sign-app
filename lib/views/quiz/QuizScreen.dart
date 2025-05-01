import 'package:flutter/material.dart';
import 'package:hand_sign/controllers/LoginController.dart';
import 'package:hand_sign/controllers/QuizController.dart';
import 'package:hand_sign/controllers/QuizListController.dart';
import 'package:hand_sign/models/Users.dart';
import 'package:hand_sign/models/quiz.dart';
import 'package:hand_sign/views/login/login.dart';
import 'package:hand_sign/views/quiz/CreateQuizPage.dart';
import 'package:hand_sign/widgets/custom/DialogHelper.dart';
import '../../widgets/custom/QuizItem.dart';
import '../../widgets/custom/CustomAppBar.dart';
import './QuizTest.dart'; // Đảm bảo đường dẫn đúng

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? _selectedType;
  List<Quiz> _allQuizzes = [];
  List<String> _quizTypes = [];
  bool _isLoading = true;
  bool _isTeacher = false;

  final QuizListController _controller = QuizListController();
  late Future<List<Quiz>> _quizFuture;

  final List<Color> colorsOption = [
    Color(0xFFDDF9FF), 
    Color(0xFFFF7996), 
    Color(0xFFFFE8E3),
    Color(0xFFE4FFE8),
    Color(0xFFF5E4FF),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();

    if (Users.currentUser?.role == 'teacher') {
      _isTeacher = true;
    }
  }

  Future<void> _loadData() async {
    final quizzes = await _controller.fetchAllQuiz();
    final types = await _controller.getQuizTypes();

    setState(() {
      _allQuizzes = quizzes;
      _quizTypes = types;
      _isLoading = false;
    });
  }

  List<Quiz> get _filteredQuizzes {
    if (_selectedType == null || _selectedType == 'Tất cả') {
      return _allQuizzes;
    }
    return _allQuizzes
        .where((quiz) => quiz.typeOfQuiz == _selectedType)
        .toList();
  }

  void _checkUserLogin(quizId){
    final user = Users.currentUser;

    if(user == null){
      DialogHelper.showConfirmDialog(
          context: context,
          title: 'Bạn chưa đăng nhập',
          message: 'Bạn có muốn đăng nhập để lưu tiến độ bài làm không?',
          confirmText: 'Đăng nhập',
          // nếu chọn đăng nhập
          onConfirm: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen()
              ),
            );
          },
          // nếu k chọn đăng nhập
          onCancel: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizTest(
                  quizId: quizId,
                  saveProgress: false, // truyền flag để không lưu tiến độ
                ),
              ),
            );
          }
      );
      // nếu user đã đăng nhập
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuizTest(
            quizId: quizId,
            saveProgress: true, // người đã đăng nhập thì lưu
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Danh sách quiz"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: _selectedType,
              hint: Text("Chọn chủ đề"),
              isExpanded: true,
              items: ['Tất cả', ..._quizTypes].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
          ),
          Expanded(
            child: _filteredQuizzes.isEmpty
                ? Center(child: Text("Không có quiz nào phù hợp"))
                : ListView.builder(
              itemCount: _filteredQuizzes.length,
              itemBuilder: (context, index) {
                final quiz = _filteredQuizzes[index];
                return QuizItem(
                  title: quiz.title,
                  score: 0,
                  color: colorsOption[index % colorsOption.length],
                  onPressed: () => _checkUserLogin(quiz.quizId),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _isTeacher
          ? FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateQuizPage()),
              );
            },
            backgroundColor: Color(0xFFFFD1BF),
            child: const Icon(Icons.add, color: Colors.black),
      )
          : null,
    );
  }
}
