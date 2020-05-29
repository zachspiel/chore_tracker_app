import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'calendar.dart';
import 'manageChores.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  void answerQuestion() {
    print("Answer chosen");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/ManageChores': (context) => ManageChoresPage(),
        '/Calendar': (context) => ViewCalendar()
      },
    );
  }
}
