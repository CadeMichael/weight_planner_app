import 'package:flutter/material.dart';
import 'workoutMath.dart';

void main() => runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final repCon = new TextEditingController();
  final weightCon = new TextEditingController();
  var _oneRepMax = "";

  void getMax() {
    String repS = repCon.value.text;
    int reps = int.parse(repS);
    String weightS = weightCon.value.text;
    double weight = (double.parse(weightS));

    setState(() {
      int rm = WorkoutMath.oneRepMax(reps, weight).floor();
      this._oneRepMax = rm.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weight Planner",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 64),
              child: Text(
                "One Rep Max Calculator",
                textScaleFactor: 2,
              ),
            ),
            Container(
              width: 100,
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: repCon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reps',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Container(
              width: 100,
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: weightCon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Container(
              child: _oneRepMax == ""
                  ? Text("your one rep Max")
                  : Text(_oneRepMax),
            ),
            FloatingActionButton(
                child: Icon(Icons.autorenew),
                splashColor: Colors.red,
                onPressed: getMax),
          ],
        ),
      ),
    );
  }
}
