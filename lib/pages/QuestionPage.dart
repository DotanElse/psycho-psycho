import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psycho_psycho/utils/question.dart';
import 'package:psycho_psycho/utils/QuestionLoader.dart';
import 'package:psycho_psycho/utils/UserData.dart';

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
  int _start = 60;
  late Timer _timer;

  TransformationController transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    questionLoader = QuestionLoader();
    loadQuestions();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void loadQuestions() async {
    await questionLoader.loadQuestions(widget.subject);
    loadRandomQuestion();
  }

  void ChangeOrientation() {
    transformationController.value = Matrix4.identity(); // Reset transformation
    if(MediaQuery.of(context).orientation == Orientation.portrait)
    {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }else
    {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  void loadRandomQuestion() {
    currentQuestion = questionLoader.getRandomQuestion();
    print("current question id is:${currentQuestion!.id}:");
    setState(() {
      transformationController.value = Matrix4.identity(); // Reset transformation
      answerSubmitted = false; // Reset answer submitted state
      selectedAnswer = ''; // Reset selected answer
      _start = 60; // Reset timer value
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if(answerSubmitted) {
          // Do nothing
        }
        else if (_start == 0) {
          _start = 60; // Reset the timer to 60 seconds
          submitAnswer();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
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
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_left), // Choose the appropriate icon for orientation change
            onPressed: ChangeOrientation, // Call the function when the button is clicked
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: CircularProgressIndicator(
              value: _start / 60, // Use _start as the countdown progress
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InteractiveViewer(
            transformationController: transformationController,
            constrained: true, // Locks the movement in the viewport
            child: Image.asset(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.3 // Adjust the height for portrait mode
                  : MediaQuery.of(context).size.width * 0.18, // Adjust the height for landscape mode
              'assets/questions_pics/${currentQuestion!.id}.jpg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05), // Adjust the spacing between the image and buttons
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
            children: [
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), // Adjust the spacing between rows
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
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: buildAnswerOption('1'),
              ),
              SizedBox(
                child: buildAnswerOption('2'),
              ),
              SizedBox(
                child: buildAnswerOption('3'),
              ),
              SizedBox(
                child: buildAnswerOption('4'),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03), // Adjust the spacing before the submit button
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: MediaQuery.sizeOf(context).height * 0.1,
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
      UserData.updateScore(currentQuestion!.subject, selectedAnswer == currentQuestion!.correct);
      //Collect statistics here
      transformationController.value = Matrix4.identity(); // Reset transformation
    });
  }

  Widget buildAnswerOption(String optionLetter) {
    Color selectedBorderColor = Colors.black; // Border color for selected button
    double borderWidth = MediaQuery.of(context).size.height * 0.005; // Border width
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
        minimumSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.15)
            : Size(MediaQuery.of(context).size.height * 0.35, MediaQuery.of(context).size.width * 0.05),
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
          fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width * 0.15 // Adjust the height for portrait mode
            : MediaQuery.of(context).size.width * 0.02, // Adjust the height for landscape mode
        ),
      ),
    );
  }
}