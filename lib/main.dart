import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Letter Grade Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Number to Letter Grade Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GradeCalculatorMainPage createState() => _GradeCalculatorMainPage();
}

class _GradeCalculatorMainPage extends State<MyHomePage> {
  double numberGrade = 0;
  String letterGrade;

  @override
  Widget build(BuildContext context) {
    if (0 <= numberGrade && numberGrade <= 59) {
      letterGrade = "F";
    } else if (60 <= numberGrade && numberGrade <= 62) {
      letterGrade = "D-";
    } else if (63 <= numberGrade && numberGrade <= 66) {
      letterGrade = "D";
    } else if (67 <= numberGrade && numberGrade <= 69) {
      letterGrade = "D+";
    } else if (70 <= numberGrade && numberGrade <= 72) {
      letterGrade = "C-";
    } else if (73 <= numberGrade && numberGrade <= 76) {
      letterGrade = "C";
    } else if (77 <= numberGrade && numberGrade <= 79) {
      letterGrade = "C+";
    } else if (80 <= numberGrade && numberGrade <= 82) {
      letterGrade = "B-";
    } else if (83 <= numberGrade && numberGrade <= 86) {
      letterGrade = "B";
    } else if (87 <= numberGrade && numberGrade <= 89) {
      letterGrade = "B+";
    } else if (90 <= numberGrade && numberGrade <= 92) {
      letterGrade = "A-";
    } else if (93 <= numberGrade && numberGrade <= 96) {
      letterGrade = "A";
    } else if (97 <= numberGrade && numberGrade <= 100) {
      letterGrade = "A+";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your score:',
            ),
            Slider(
              value: numberGrade,
              onChanged: (newRating) {
                setState(() => numberGrade = newRating);
              },
              min: 0,
              max: 100,
              divisions: 100,
              label: '$numberGrade',
            ),
            Text(
              '$numberGrade',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text("Your letter grade is:"),
            Text(letterGrade),
          ],
        ),
      ),
    );
  }
}
