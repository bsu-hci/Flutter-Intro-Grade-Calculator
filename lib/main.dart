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
  int standardLetterid = 0;
  bool isTriage = false;
  int groupValue = 1;
  String triageLetterGrade = "";
  String userInput;
  double pointsEarned;
  double pointsPossible;
  double singleGradeValue;
  int triageLetterid = 0;
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

  void validator(input) {
    if (double.tryParse(input) == null) {
      setState(() {
        triageLetterGrade =
            "Error: Input must be numeric. Try entering input that is only numbers.";
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
        triageLetterGrade =
            "Error: Points possible cannot be 0. Try entering a value here greater than 0.";
      });
    } else if (pointsEarned > pointsPossible) {
      setState(() {
        triageLetterGrade =
            "Error: Points earned cannot exceed points possible. Try entering a points earned value smaller than points possible value.";
      });
    } else if (pointsEarned != null && pointsPossible != null) {
      singleGradeValue = pointsEarned / pointsPossible;
      triageLetterid = 0;
      while (triageLetterid < 4 &&
          singleGradeValue > triageCutoff[triageLetterid]) {
        triageLetterid++;
      }
      setState(() {
        triageLetterGrade = triageLetters[triageLetterid];
      });
    }
  }

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
      standardLetterid = 0;
      while (standardLetterid < 12 &&
          numberGrade >= standardCutoff[standardLetterid]) {
        standardLetterid++;
      }
      return standardLetters[standardLetterid];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .1,
            right: MediaQuery.of(context).size.width * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Standard:", style: TextStyle(fontSize: 20)),
                Radio(
                  onChanged: (val) {
                    isTriage = false;
                    setState(() {
                      groupValue = val;
                    });
                  },
                  value: 1,
                  groupValue: groupValue,
                ),
                Text("Triage:", style: TextStyle(fontSize: 20)),
                Radio(
                  onChanged: (val) {
                    isTriage = true;
                    setState(() {
                      groupValue = val;
                    });
                  },
                  value: 2,
                  groupValue: groupValue,
                ),
              ],
            ),
            if (isTriage == false)
              Container(
                  child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    'Input your score by using the slider below:',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Slider(
                  value: numberGrade,
                  onChanged: (newRating) {
                    setState(() => numberGrade = newRating);
                  },
                  min: 0,
                  max: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('$roundedNumberGrade',
                      style: TextStyle(color: Colors.black, fontSize: 50)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Your letter grade is:",
                      style: TextStyle(fontSize: 30)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(getLetterGradeStandard(numberGrade),
                      style: TextStyle(fontSize: 50)),
                ),
              ])),
            if (isTriage == true)
              Container(
                  child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text("Enter points earned and total points possible.",
                      style: TextStyle(fontSize: 30)),
                ),
                Row(children: [
                  Flexible(
                    child: TextField(
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: pointsEarnedInput,
                        onChanged: (text) {
                          validator(pointsEarnedInput.text);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text("/", style: TextStyle(fontSize: 30)),
                  ),
                  Flexible(
                      child: TextField(
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: pointsPossibleInput,
                    onChanged: (text) {
                      validator(pointsPossibleInput.text);
                    },
                  ))
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 15),
                  child: Text(
                    "Your grade is:",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    triageLetterGrade,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ]))
          ],
        ),
      ),
    );
  }
}
