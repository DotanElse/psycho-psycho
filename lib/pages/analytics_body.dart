import 'package:flutter/material.dart';
import 'package:psycho_psycho/utils/UserData.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('שגיאה: ${snapshot.error}'),
          );
        } else {
          final userData = snapshot.data!;
          final mathStats = userData[0];
          final totalMathQuestions = userData[1];
          final hebrewStats = userData[2];
          final totalHebrewQuestions = userData[3];
          final englishStats = userData[4];
          final totalEnglishQuestions = userData[5];
          final totalQuestions = totalMathQuestions + totalHebrewQuestions + totalEnglishQuestions;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildSubjectRow(context, 'מתמטיקה', mathStats, totalMathQuestions),
                _buildSubjectRow(context, 'עברית', hebrewStats, totalHebrewQuestions),
                _buildSubjectRow(context, 'אנגלית', englishStats, totalEnglishQuestions),
                Divider(),
                _buildTotalRow(context, totalQuestions),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<int>> _getUserData() async {
    final mathData = await UserData.getScore('m');
    final hebrewData = await UserData.getScore('h');
    final englishData = await UserData.getScore('e');
    return [
      ...mathData,
      ...hebrewData,
      ...englishData,
    ];
  }

  Widget _buildSubjectRow(BuildContext context, String subject, int correct, int totalQuestions) {
    final percentage = totalQuestions == 0 ? 0 : (correct / totalQuestions) * 100;
    return ListTile(
      title: Text('$subject: $correct/$totalQuestions'),
      subtitle: Text('אחוזים: ${percentage.toStringAsFixed(2)}%'),
    );
  }

  Widget _buildTotalRow(BuildContext context, int totalQuestions) {
    return ListTile(
      title: Text('סה"כ שאלות: $totalQuestions'),
    );
  }
}
