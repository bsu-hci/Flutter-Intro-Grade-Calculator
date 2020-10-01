import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  String letterGrade2;
  String userInput;
  double pointsEarned;
  double pointsPossible;
  double singleGradeValue;
  int letterid = 0;

  var triageLetters = [
    "F",
    "D",
    "C",
    "B",
    "A",
  ];
  var triageCutoff = [(7 / 15), (2 / 3), (5 / 6), (17 / 18)];

  String getLetterEquivalent() {
    if (pointsEarned != null &&
        pointsPossible != null &&
        pointsEarned < pointsPossible) {
      singleGradeValue = pointsEarned / pointsPossible;
      letterid = 0;
      while (letterid < 3 && singleGradeValue >= triageCutoff[letterid]) {
        letterid++;
      }
      letterGrade = triageLetters[letterid];
    }
    return letterGrade;
  }

  String isNumber(String userInput) {
    if (double.tryParse(userInput) == null) {
      return "Input must be numeric.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Number to Letter Grade Converter")),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 300.0,
                      height: 25.0,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (userInput) {
                          String validated = isNumber(userInput);
                          if (validated == null) {
                            pointsEarned = double.parse(userInput);
                          }
                          return validated;
                        },
                      ),
                    ),
                    Text("/"),
                    SizedBox(
                        width: 300.0,
                        height: 25.0,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (userInput) {
                            String validated = isNumber(userInput);
                            if (validated == null) {
                              pointsPossible = double.parse(userInput);
                              if (pointsPossible == 0) {
                                return "Error: points possible cannot be zero.";
                              }
                              if (pointsPossible < pointsEarned) {
                                return "Error: points earned cannot be greater than points possible.";
                              }
                            }
                            return validated;
                          },
                        ))
                  ]),
              Text("Your grade is:"),
              Text(getLetterEquivalent()),
            ])));
  }
}
