import 'package:flutter/material.dart';
import 'package:psycho_psycho/utils/question.dart';
import 'package:psycho_psycho/utils/QuestionLoader.dart';

class QuestionPage extends StatefulWidget {
  final String subject;

  QuestionPage({required this.subject});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Question? currentQuestion;
  late QuestionLoader questionLoader;
  String selectedAnswer = '';
  bool answerSubmitted = false;
  double scaleFactor = 1.0;

  TransformationController transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    questionLoader = QuestionLoader();
    loadQuestions();
  }

  void loadQuestions() async {
    await questionLoader.loadQuestions(widget.subject);
    loadRandomQuestion();
  }

  void loadRandomQuestion() {
    currentQuestion = questionLoader.getRandomQuestion();
    setState(() {
      transformationController.value = Matrix4.identity(); // Reset transformation
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InteractiveViewer(
            transformationController: transformationController,
            constrained: true, // Locks the movement in the viewport
            child: Image.asset(
              height: MediaQuery.sizeOf(context).height*0.3,
              'assets/questions_pics/${currentQuestion!.id}.jpg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 16.0), // Adjust the spacing between the image and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: buildAnswerOption('1'),
              ),
              SizedBox(
                child: buildAnswerOption('2'),
              ),
            ],
          ),
          SizedBox(height: 16.0), // Adjust the spacing between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: buildAnswerOption('3'),
              ),
              SizedBox(
                child: buildAnswerOption('4'),
              ),
            ],
          ),
          SizedBox(height: 16.0), // Adjust the spacing before the submit button
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).height*0.2,
              height: MediaQuery.sizeOf(context).height*0.05,
              child: ElevatedButton(
                onPressed: answerSubmitted ? loadRandomQuestion : submitAnswer,
                child: Text(answerSubmitted ? 'שאלה הבאה' : 'שליחה'),
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
      transformationController.value = Matrix4.identity(); // Reset transformation
    });
  }

  Widget buildAnswerOption(String optionLetter) {
    Color selectedBorderColor = Colors.black; // Border color for selected button
    double borderWidth = 4.0; // Border width
    Color? disabledColor = Colors.grey;
    if (answerSubmitted) {
      if (optionLetter == selectedAnswer) {
        disabledColor = Colors.red;
      }
      if (optionLetter == currentQuestion!.correct) {
        disabledColor = Colors.green;
      }
    }

    return ElevatedButton(
      onPressed: answerSubmitted
          ? null
          : () {
        setState(() {
          selectedAnswer = optionLetter;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Use your preferred color here
        disabledBackgroundColor: disabledColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.width * 0.3), // Adjust button size as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05), // Adjust borderRadius as needed
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
          fontSize: MediaQuery.of(context).size.width * 0.15, // Adjust fontSize as needed
        ),
      ),
    );
  }
}
