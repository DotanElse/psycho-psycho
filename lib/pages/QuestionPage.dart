import 'package:flutter/material.dart';
import 'package:psycho_psycho/utils/question.dart';
import 'package:psycho_psycho/utils/QuestionLoader.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Question currentQuestion;
  late QuestionLoader questionLoader;
  String selectedAnswer = '';
  bool answerSubmitted = false;

  @override
  void initState() {
    super.initState();
    questionLoader = QuestionLoader();
    loadQuestions();
  }

  void loadQuestions() async {
    await questionLoader.loadQuestions();
    loadRandomQuestion();
  }

  void loadRandomQuestion() {
    currentQuestion = questionLoader.getRandomQuestion();
    setState(() {
      answerSubmitted = false; // Reset answer submitted state
      selectedAnswer = ''; // Reset selected answer
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Column(
              children: [
                buildAnswerOption(currentQuestion.optionA, 'A'),
                buildAnswerOption(currentQuestion.optionB, 'B'),
                buildAnswerOption(currentQuestion.optionC, 'C'),
                buildAnswerOption(currentQuestion.optionD, 'D'),
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: answerSubmitted ? loadRandomQuestion : submitAnswer,
                child: Text(answerSubmitted ? 'Next Question' : 'Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitAnswer() {
    setState(() {
      answerSubmitted = true;
    });
  }

  Widget buildAnswerOption(String option, String optionLetter) {
    Color? color;
    if (answerSubmitted) {
      if (optionLetter == currentQuestion.correct) {
        color = Colors.green;
      } else if (optionLetter == selectedAnswer) {
        color = Colors.red;
      }
    }

    return ListTile(
      title: Text(
        option,
        style: TextStyle(color: color),
      ),
      leading: Radio(
        value: optionLetter,
        groupValue: selectedAnswer,
        onChanged: answerSubmitted
            ? null
            : (value) {
          setState(() {
            selectedAnswer = value.toString();
          });
        },
      ),
    );
  }
}
