import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

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

  var standardLetters = [
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
  var standardCutoff = [60, 63, 67, 70, 73, 77, 80, 83, 87, 90, 93, 97];

  @override
  Widget build(BuildContext context) {
    roundedNumberGrade = numberGrade.round();

    String getLetterGradeStandard(numberGrade) {
      letterid = 0;
      while (letterid < 12 && numberGrade >= standardCutoff[letterid]) {
        letterid++;
      }
      return standardLetters[letterid];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Standard',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TriagePage()));
                },
                child: Text('Triage'),
              ),
            ]),
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
            Text(getLetterGradeStandard(numberGrade)),
          ],
        ),
      ),
    );
  }
}

class TriagePage extends StatefulWidget {
  @override
  _TriagePageState createState() => _TriagePageState();
}

class _TriagePageState extends State<TriagePage> {
  String letterGrade = "";
  String userInput;
  double pointsEarned;
  double pointsPossible;
  double singleGradeValue;
  int letterid = 0;
  var pointsEarnedInput = TextEditingController();
  var pointsPossibleInput = TextEditingController();

  var triageLetters = [
    "F",
    "D",
    "C",
    "B",
    "A",
  ];
  var triageCutoff = [(7 / 15), (2 / 3), (5 / 6), (17 / 18)];

  void validator() {
    if (double.tryParse(pointsEarnedInput.text) == null ||
        double.tryParse(pointsPossibleInput.text) == null) {
      setState(() {
        letterGrade = "Error: Input must be numeric.";
      });
    } else {
      getLetterEquivalent();
    }
  }

  void getLetterEquivalent() {
    pointsEarned = double.parse(pointsEarnedInput.text);
    pointsPossible = double.parse(pointsPossibleInput.text);
    if (pointsPossible == 0) {
      setState(() {
        letterGrade = "Error: Points possible cannot be 0.";
      });
    } else if (pointsEarned > pointsPossible) {
      setState(() {
        letterGrade = "Error: Points earned cannot exceed points possible.";
      });
    } else if (pointsEarned != null && pointsPossible != null) {
      singleGradeValue = pointsEarned / pointsPossible;
      letterid = 0;
      while (letterid < 3 && singleGradeValue >= triageCutoff[letterid]) {
        letterid++;
      }
      setState(() {
        letterGrade = triageLetters[letterid];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Number to Letter Grade Converter")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Standard'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Triage',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
              ),
            ]),
            Text("Enter points earned and total points possible."),
            Container(
              child: Row(children: [
                Flexible(
                  child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: pointsEarnedInput,
                      onChanged: (text) {
                        validator();
                      }),
                ),
                Text("/"),
                Flexible(
                    child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: pointsPossibleInput,
                  onChanged: (text) {
                    validator();
                  },
                ))
              ]),
            ),
            Text("Your grade is:"),
            Text(letterGrade),
          ],
        ),
      ),
    );
  }
}
