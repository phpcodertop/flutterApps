import 'package:quizzler/question.dart';

class QuizBrain {

  int _questionNumber = 0;
  int score = 1;

  final List<Question> _questionsBank = [
    Question( "A male zebra and a female horse is called a 'zorse', and a female zebra and a male horse is called a 'zonkey'",
         false),
    Question('M&M stands for Mars and Murrie', false),
    Question("The moon sits at 3400km in diameter, while Australia's diameter from east to west is almost 4000km", true),
    Question('Their memories can actually last for months.', false),
    Question("A process called 'negative geotropism' means the fruit grows upwards to break through the canopy.", true),
  ];

  void nextQuestion()
  {
    if(_questionNumber < _questionsBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText()
  {
    return _questionsBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer()
  {
    return _questionsBank[_questionNumber].questionAnswer;
  }

  bool hasNewQuestion()
  {
    if(_questionNumber < _questionsBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }



  void resetExam()
  {
    _questionNumber = 0;
    score = 0;
  }

  int getQuestionsCount() {
    return _questionsBank.length;
  }

}