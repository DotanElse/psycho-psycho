import 'package:flutter/material.dart';
import 'package:psycho_psycho/utils/UserData.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<List<int>>(
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

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildSubjectRow(context, 'מתמטיקה', mathStats, totalMathQuestions),
                _buildSubjectRow(context, 'עברית', hebrewStats, totalHebrewQuestions),
                _buildSubjectRow(context, 'אנגלית', englishStats, totalEnglishQuestions),
                Divider(),
                _buildTotalRow(context, totalQuestions),
                SizedBox(height: 16.0),
                _buildResetButton(context),
              ],
            );
          }
        },
      ),
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
      subtitle: Text('אחוז: ${percentage.toStringAsFixed(2)}%'),
    );
  }

  Widget _buildTotalRow(BuildContext context, int totalQuestions) {
    return ListTile(
      title: Text('סה"כ שאלות: $totalQuestions'),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showResetConfirmationDialog(context),
      child: Text('איפוס נתונים'),
    );
  }

  Future<void> _showResetConfirmationDialog(BuildContext context) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('איפוס נתונים'),
            content: Text('האם אתה בטוח שברצונך לאפס את כל הנתונים? לא ניתן לבטל פעולה זו.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('ביטול'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('אישור'),
              ),
            ],
          ),
        );
      },
    );

    if (shouldReset != null && shouldReset) {
      _resetStatistics();
      setState(() {}); // Update the state to reflect the changes
    }
  }


  void _resetStatistics() {
    UserData.resetStatistics();
    setState(() {}); // Update the state to reflect the changes
  }
}
