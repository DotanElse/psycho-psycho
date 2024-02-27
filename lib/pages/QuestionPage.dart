// question_page.dart
import 'package:flutter/material.dart';
import 'package:psycho_psycho/utils/question.dart';
import 'package:psycho_psycho/utils/QuestionLoader.dart';
// question_page.dart

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Question currentQuestion;
  late QuestionLoader questionLoader;

  @override
  void initState() {
    super.initState();
    questionLoader = QuestionLoader();
    // Load questions when the page is initialized
    loadQuestions();
  }

  void loadQuestions() async {
    // Load questions using the QuestionLoader
    await questionLoader.loadQuestions();
    // Load a random question after questions are loaded
    loadRandomQuestion();
  }

  void loadRandomQuestion() {
    // Load a random question using the QuestionLoader
    currentQuestion = questionLoader.getRandomQuestion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == null) {
      // Handle the case when a question is not loaded yet
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
            // Display the question
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // Display the answer options with radio buttons
            Column(
              children: [
                buildAnswerOption(currentQuestion.optionA),
                buildAnswerOption(currentQuestion.optionB),
                buildAnswerOption(currentQuestion.optionC),
                buildAnswerOption(currentQuestion.optionD),
              ],
            ),
            SizedBox(height: 16.0),
            // Display a submit button
            ElevatedButton(
              onPressed: () {
                // Handle the submission logic here
                // For example, check if the selected option is correct
                if (currentQuestion.correct == 'A' && currentQuestion.correct == 'A') {
                  // Correct answer
                  print('Correct!');
                } else {
                  // Incorrect answer
                  print('Incorrect!');
                }

                // Load a new random question
                loadRandomQuestion();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnswerOption(String option) {
    return ListTile(
      title: Text(option),
      leading: Radio(
        value: option,
        groupValue: currentQuestion.correct,
        onChanged: (value) {
          // Handle the selection logic if needed
        },
      ),
    );
  }
}
