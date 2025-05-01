import 'dart:typed_data';

class Question{
  String questionId;
  String questionText;
  int correctAnswerIndex;
  List<String> options;
  String imgURL;

  Uint8List? selectedImageFile;
  String? selectedImageName;

  Question({
    required this.questionId,
    required this.questionText,
    required this.correctAnswerIndex,
    required this.options,
    this.imgURL = '',
    this.selectedImageFile,
    this.selectedImageName,
});

  factory Question.fromMap(Map<String, dynamic> map,String id){
    return Question(
        questionId: id,
        questionText: map['questionText'],
        correctAnswerIndex: map['correctAnswer'],
        options: List<String>.from(map['options']),
        imgURL: map['imgURL'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'questionId': questionId,
      'questionText': questionText,
      'options': options,
      'correctAnswer': correctAnswerIndex,
      'imgURL': imgURL,
    };
  }
}