import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hand_sign/services/ImgUploadService.dart';
import 'package:hand_sign/views/quiz/QuizScreen.dart';
import 'package:hand_sign/widgets/custom/CustomAppBar.dart';
import 'package:hand_sign/widgets/custom/customButton.dart';
import '../../controllers/QuizController.dart';
import '../../models/question.dart';
import '../../models/quiz.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/QuizService.dart';

class CreateQuizPage extends StatefulWidget{
   // final String createdBy;

   const CreateQuizPage({
     super.key,
     // required this.createdBy
});

   @override
   State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final PageController _pageController = PageController();
  final QuizController _controller = QuizController(ImgUploadService(),
    QuizService(),);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.initEmptyQuestions();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _goToNextPage(int index){
    final msg = _controller.isCurrentQuestionValid(index);
    if (msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }
    if (index == _controller.questions.length - 1) {
      setState(() {
        _controller.questions.add(
            Question(
              questionId: DateTime.now().millisecondsSinceEpoch.toString(),
              questionText: '',
              correctAnswerIndex: 0,
              options: List.filled(4, ''),
            )
        );
      });
    }
    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _saveQuiz() async{
    await _controller.saveQuiz();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lưu quiz thành công")));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => QuizScreen()),
          (Route<dynamic> route) => false,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thêm mới Quiz'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.questions.length +1,
          itemBuilder:(context, index){
            if(index == 0){
              return _buildFirstPage();
            }else{
              return _buildQuestionForm(index -1);
            }
          }
        ),
      ),
    );
  }

  Widget _buildFirstPage(){
    return Padding(
        padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  'Tiêu đề Quiz:',
                   textAlign: TextAlign.left,
                   style: TextStyle(fontSize: 20, color: Color(0xFF660000))
                 ),
                 SizedBox(height: 10,),
                 _buildInputField(
                   'Nhập tiêu đề mô tả quiz',
                   _titleController
                  ),
                 SizedBox(height: 30),
                 Text(
                  'Chủ đề Quiz:',
                  style: TextStyle(fontSize: 20, color: Color(0xFF660000))
                 ),
                 SizedBox(height: 10,),
                 _buildInputField(
                     'Nhập chủ đề quiz',
                     _typeController),
                 SizedBox(height: 40),
                 Align(
                   alignment: Alignment.center,
                   child: CustomButton(
                       text: "Tiếp tục",
                       textColor: Colors.white,
                       gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)],
                       onPressed: (){
                         if (_titleController.text.isEmpty || _typeController.text.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")));
                         } else {
                           _controller.setQuizInfo(
                               title: _titleController.text,
                               topic: _typeController.text,
                           );
                           _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                         }
                       }
                   ),
                 )
              ],
         ),
    );
  }

  Widget _buildQuestionForm(int index) {
    Question question = _controller.questions[index];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Câu hỏi ${index + 1}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(
              'Nội dung câu hỏi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            TextField(
              onChanged: (value) => question.questionText = value,
              controller: TextEditingController(text: question.questionText),
            ),
            SizedBox(height: 20,),
            _buildImagePicker(index, question),
            SizedBox(height: 12),
            Text(
              'Nhập các đáp án, chọn trước đáp án đúng!',
              style: TextStyle(fontSize: 15),
            ),
            for (int i = 0; i < 4; i++)
              RadioListTile<int>(
                title: TextField(
                  decoration: InputDecoration(labelText: "Đáp án ${i + 1}"),
                  onChanged: (value) => question.options[i] = value ?? '',
                  controller: TextEditingController(text: question.options[i]),
                ),
                value: i,
                groupValue: question.correctAnswerIndex,
                onChanged: (value) => setState(() => question.correctAnswerIndex = value!),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                CustomButton(
                    text: "← Quay lại",
                    textColor: Colors.white,
                    gradientColors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                  onPressed: () {
                    if (index == 0) {
                      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    } else {
                      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                    width: 170,
                  ),
                SizedBox(width: 10),
                CustomButton(
                    text: "Tiếp tục >>",
                    textColor: Colors.white,
                    gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)],
                    onPressed: () {
                      _goToNextPage(index);
                  },
                    width: 170,
                )
              ],
            ),
            SizedBox(height: 20),
            if(_controller.questions.length >= 10)
              CustomButton(
                text: "Lưu Quiz",
                textColor: Colors.white,
                gradientColors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                onPressed: _saveQuiz,
                width: double.infinity, 
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
      ),
      controller: controller,
    );
  }

  Widget _buildImagePicker(int index, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chọn ảnh minh hoạ:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        if (question.selectedImageFile != null)
          Image.memory(question.selectedImageFile!, height: 150),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () async {
            final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (picked != null) {
              final bytes = await picked.readAsBytes();

              final updated = Question(
                questionId: question.questionId,
                questionText: question.questionText,
                options: question.options,
                correctAnswerIndex: question.correctAnswerIndex,
                selectedImageFile: bytes,
              );
              setState(() {
                _controller.updateQuestion(index, updated);
              });
            }
          },
          icon: Icon(Icons.image),
          label: Text('Chọn ảnh'),
        ),
      ],
    );
  }

}

