import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'question.dart';

class QuestionLoader {
  List<Question> _questions = [];

  Future<void> loadQuestions() async {
    try {
      // Load the CSV file from the assets
      String csvString = await rootBundle.loadString('assets/questions.csv');
      List<String> lines = csvString.split('\n');
      lines.removeWhere((line) => line.trim().isEmpty);
      // Remove the header line (assuming the header is present in the first line)
      lines.removeAt(0);

      // Parse each CSV line into a Question object
      _questions = lines.map((line) {
        var questionFields = line.split(',');
        print(questionFields);
        return Question(
          text: questionFields[0],
          optionA: questionFields[1],
          optionB: questionFields[2],
          optionC: questionFields[3],
          optionD: questionFields[4],
          correct: questionFields[5],
          id: questionFields[6],
          subject: questionFields[7],
          category: questionFields[8],
          difficulty: questionFields[9],
        );
      }).toList();
    } catch (e) {
      print('Error loading questions: $e');
      // Handle the error as needed
    }
  }

  Question getRandomQuestion() {
    // Select a random question
    var random = Random();
    var randomIndex = random.nextInt(_questions.length);
    return _questions[randomIndex];
  }
}
