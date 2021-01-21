import 'package:flutter/material.dart';
import 'package:weight_planner_app/storage.dart';
import 'workoutMath.dart';
import 'relativeInt.dart';
import 'exercise.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ExerciseAdapter());
  var box = await Hive.openBox('exercises');
  runApp(
    MaterialApp(
      home: Max(),
    ),
  );
}

class Max extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaxState();
  }
}

class _MaxState extends State<Max> {
  final repCon = new TextEditingController();
  final weightCon = new TextEditingController();
  var _oneRepMax = "";
  List<Widget> columnForm = [];

  void getMax() {
    String repS = repCon.value.text;
    String weightS = weightCon.value.text;

    int rm;
    String rmS;
    try {
      int reps = int.parse(repS);
      double weight = (double.parse(weightS));
      rm = WorkoutMath.oneRepMax(reps, weight).floor();
      rmS = rm.toString();
    } catch (e) {
      rmS = "";
    }
    setState(() {
      repCon.clear();
      weightCon.clear();
      this._oneRepMax = rmS;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "One Rep Max Calculator",
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
                  padding: EdgeInsets.fromLTRB(8, 64, 8, 32),
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
                  margin: EdgeInsets.fromLTRB(8, 32, 8, 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _oneRepMax == ""
                      ? Text(
                          "your one rep Max",
                          textScaleFactor: 2,
                        )
                      : Text(
                          _oneRepMax,
                          textScaleFactor: 3,
                        ),
                ),
                FloatingActionButton(
                  heroTag: 'button1',
                  child: Icon(Icons.autorenew),
                  splashColor: Colors.red,
                  onPressed: getMax,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    child: Text("Relative Intensity"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RelativeInt(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    child: Text("Storage"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Storage(),
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
