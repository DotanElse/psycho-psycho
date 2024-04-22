import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'question.dart';

class QuestionLoader {
  List<Question> _questions = [];

  Future<void> loadQuestions(String questionType) async {
    try {
      // Load the CSV file from the assets
      String csvString = await rootBundle.loadString('assets/questions.csv');
      List<String> lines = csvString.split('\n');
      lines.removeWhere((line) => line.trim().isEmpty);
      // Remove the header line (assuming the header is present in the first line)
      lines.removeAt(0);

      _questions.clear(); // Clear the list before adding new questions

      // Parse each CSV line into a Question object
      lines.forEach((line) {
        var questionFields = line.split(',');

        // Check if the subject matches the specified questionType
        if (questionType == 'a' || questionFields[3].trim() == questionType.trim()) {
          _questions.add(Question(
            id: questionFields[0],
            correct: questionFields[1],
            difficulty: questionFields[2],
            subject: questionFields[3],
          ));
        }
      });

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
