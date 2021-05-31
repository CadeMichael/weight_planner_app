import 'package:flutter/material.dart';
import 'workoutMath.dart';
import 'main.dart';
import 'package:hive/hive.dart';

class RelativeInt extends StatefulWidget {
  final Box box;
  RelativeInt(this.box);
  @override
  State<StatefulWidget> createState() {
    return _RelativeIntState(box);
  }
}

class _RelativeIntState extends State<RelativeInt> {
  final Box box;
  _RelativeIntState(this.box);
  final repCon = new TextEditingController();
  final weightCon = new TextEditingController();
  final rmCon = new TextEditingController();

  final relRMCon = new TextEditingController();
  final desiredRel = new TextEditingController();
  final relRepCon = new TextEditingController();

  var _relIntensity = "";

  void getRel() {
    String repS = repCon.value.text;
    String weightS = weightCon.value.text;
    String rmS = rmCon.text;

    int rel;
    String relS;
    try {
      int reps = int.parse(repS);
      double weight = (double.parse(weightS));
      double rm = double.parse(rmS);
      rel = (WorkoutMath.relativeIntensity(reps, weight, rm) * 100).floor();
      relS = (rel).toString() + "%";
    } catch (e) {
      relS = "";
    }
    setState(() {
      repCon.clear();
      weightCon.clear();
      rmCon.clear();
      this._relIntensity = relS;
    });
  }

  var _newRel = "";
  void getNewRel() {
    String relRepS = relRepCon.value.text;
    String relRmS = relRMCon.value.text;
    String newRelS = desiredRel.text;

    double newRel;
    String relWeightS;
    try {
      int reps = int.parse(relRepS);
      double desiredRel = (double.parse(newRelS));
      double rm = double.parse(relRmS);
      newRel = WorkoutMath.increasedAi(reps, desiredRel);
      relWeightS = (newRel * rm).floor().toString();
    } catch (e) {
      relWeightS = "";
    }
    setState(() {
      relRepCon.clear();
      desiredRel.clear();
      relRMCon.clear();
      this._newRel = relWeightS;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Relative Intensity Calculator",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  padding: EdgeInsets.fromLTRB(8, 64, 8, 8),
                  child: TextField(
                    controller: repCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Reps',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: weightCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: rmCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '1RM',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 32, 8, 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _relIntensity == ""
                      ? Text(
                          "Relative Intensity",
                          textScaleFactor: 2,
                        )
                      : Text(
                          _relIntensity,
                          textScaleFactor: 3,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 64),
                  child: FloatingActionButton(
                    child: Icon(Icons.autorenew),
                    splashColor: Colors.red,
                    onPressed: getRel,
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: relRepCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Reps',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: relRMCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '1RM',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: desiredRel,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Desired RI',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 32, 8, 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _newRel == ""
                      ? Text(
                          "Weight",
                          textScaleFactor: 2,
                        )
                      : Text(
                          _newRel,
                          textScaleFactor: 3,
                        ),
                ),
                FloatingActionButton(
                  heroTag: 'button2',
                  child: Icon(Icons.autorenew),
                  splashColor: Colors.red,
                  onPressed: getNewRel,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: RaisedButton(
                    child: Text("One Rep Max"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Max(box),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
