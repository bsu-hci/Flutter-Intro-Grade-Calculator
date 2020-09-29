import 'package:flutter/material.dart';

void main() {
  runApp(GradeConverterApp());
}

class GradeConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Letter Grade Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GradeConverterHomePage(title: 'Number to Letter Grade Converter'),
    );
  }
}

class GradeConverterHomePage extends StatefulWidget {
  GradeConverterHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GradeCalculatorMainPage createState() => _GradeCalculatorMainPage();
}

class _GradeCalculatorMainPage extends State<GradeConverterHomePage> {
  double numberGrade = 0;
  int roundedNumberGrade;
  String letterGrade;
  int letterid = 0;

  var letters = [
    "F",
    "D-",
    "D",
    "D+",
    "C-",
    "C",
    "C+",
    "B-",
    "B",
    "B+",
    "A-",
    "A",
    "A+"
  ];
  var cutoff = [60, 63, 67, 70, 73, 77, 80, 83, 87, 90, 93, 97];

  @override
  Widget build(BuildContext context) {
    roundedNumberGrade = numberGrade.round();

    String getLetterGrade(numberGrade) {
      letterid = 0;
      while (letterid < 12 && numberGrade >= cutoff[letterid]) {
        letterid++;
      }
      return letters[letterid];
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
            ),
            Text(
              '$roundedNumberGrade',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text("Your letter grade is:"),
            Text(getLetterGrade(numberGrade)),
          ],
        ),
      ),
    );
  }
}
