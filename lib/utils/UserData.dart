import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static const String totalQuestionsMathKey = 'totalQuestionsMath';
  static const String totalCorrectMathKey = 'totalCorrectMathKey';
  static const String totalQuestionsHebrewKey = 'totalQuestionsHebrew';
  static const String totalCorrectHebrewKey = 'totalCorrectHebrew';
  static const String totalQuestionsEnglishKey = 'totalQuestionsEnglish';
  static const String totalCorrectEnglishKey = 'totalCorrectEnglish';

  // Function to save the total number of questions answered
  static Future<void> updateScore(String subject, bool correct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int curr;
    subject = subject.trim();
    if(subject == 'm')
      {
        curr = prefs.getInt(totalQuestionsMathKey) ?? 0;
        prefs.setInt(totalQuestionsMathKey, curr+1);
        if(correct)
          {
            curr = prefs.getInt(totalCorrectMathKey) ?? 0;
            prefs.setInt(totalCorrectMathKey, curr+1);
          }
        return;
      }
    if(subject == 'h')
    {
      curr = prefs.getInt(totalQuestionsHebrewKey) ?? 0;
      prefs.setInt(totalQuestionsHebrewKey, curr+1);
      if(correct)
      {
        curr = prefs.getInt(totalCorrectHebrewKey) ?? 0;
        prefs.setInt(totalCorrectHebrewKey, curr+1);
      }
      return;
    }
    if(subject == 'e')
    {
      curr = prefs.getInt(totalQuestionsEnglishKey) ?? 0;
      prefs.setInt(totalQuestionsEnglishKey, curr+1);
      if(correct)
      {
        curr = prefs.getInt(totalCorrectEnglishKey) ?? 0;
        prefs.setInt(totalCorrectEnglishKey, curr+1);
      }
      return;
    }
  }
  static Future<List<int>> getScore(String subject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(subject == 'm')
      {
        return [prefs.getInt(totalCorrectMathKey) ?? 0, prefs.getInt(totalQuestionsMathKey) ?? 0];
      }
    if(subject == 'h')
      {
        return [prefs.getInt(totalCorrectHebrewKey) ?? 0, prefs.getInt(totalQuestionsHebrewKey) ?? 0];
      }
    if(subject == 'e')
    {
      return [prefs.getInt(totalCorrectEnglishKey) ?? 0, prefs.getInt(totalQuestionsEnglishKey) ?? 0];
    }
    return [(prefs.getInt(totalCorrectMathKey) ?? 0) +
        (prefs.getInt(totalCorrectHebrewKey) ?? 0) +
        (prefs.getInt(totalCorrectEnglishKey) ?? 0)
      , (prefs.getInt(totalQuestionsMathKey) ?? 0) +
        (prefs.getInt(totalQuestionsHebrewKey) ?? 0) +
        (prefs.getInt(totalQuestionsEnglishKey) ?? 0)];
  }

  static Future<void> resetStatistics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(totalQuestionsMathKey);
    await prefs.remove(totalCorrectMathKey);
    await prefs.remove(totalQuestionsHebrewKey);
    await prefs.remove(totalCorrectHebrewKey);
    await prefs.remove(totalQuestionsEnglishKey);
    await prefs.remove(totalCorrectEnglishKey);
  }
}