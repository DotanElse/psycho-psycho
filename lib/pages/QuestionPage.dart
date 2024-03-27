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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset(
              'assets/questions_pics/${currentQuestion.id}.jpg', // Adjust the path as needed
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for options A and B
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAnswerOption('1'),
                      buildAnswerOption('2'),
                    ],
                  ),
                  SizedBox(height: 16.0), // Adjust the spacing between rows
                  // Row for options C and D
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAnswerOption('3'),
                      buildAnswerOption('4'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: answerSubmitted ? loadRandomQuestion : submitAnswer,
                        child: Text(answerSubmitted ? 'Next Question' : 'Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitAnswer() {
    setState(() {
      answerSubmitted = true;
    });
  }

  Widget buildAnswerOption(String optionLetter) {
    double buttonSize = MediaQuery.of(context).size.width * 0.4; // Adjust size as needed
    Color selectedBorderColor = Colors.black; // Border color for selected button
    double borderWidth = 4.0; // Border width
    Color? disabledColor = Colors.grey;
    if(answerSubmitted)
      {
        if(optionLetter == selectedAnswer)
          {
            disabledColor = Colors.red;
          }
        if(optionLetter == currentQuestion.correct)
          {
            disabledColor = Colors.green;
          }
      }


    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        onPressed: answerSubmitted ? null : () {
          setState(() {
            selectedAnswer = optionLetter;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Use your preferred color here
          disabledBackgroundColor: disabledColor,
          minimumSize: Size(buttonSize, buttonSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonSize * 0.3), // Adjust borderRadius as needed
            side: BorderSide(
              color: selectedAnswer == optionLetter ? selectedBorderColor : Colors.transparent,
              width: borderWidth,
            ),
          ),
        ),
        child: Text(
          optionLetter,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: buttonSize * 0.5, // Adjust fontSize as needed
          ),
        ),
      ),
    );
  }
}
