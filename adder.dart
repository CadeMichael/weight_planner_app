import 'package:flutter/material.dart';
import 'exercise.dart';
import 'package:hive/hive.dart';
import 'package:weight_planner_app/exercise.dart';

class Adder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdderState();
  }
}

class _AdderState extends State<Adder> {
  final nameCon = new TextEditingController();
  final weightCon = new TextEditingController();

  void add() {
    try {
      final exerciseBox = Hive.box('exercise');
      exerciseBox.add(
        Exercise(nameCon.text.toString(), int.parse(weightCon.text.toString())),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      nameCon.clear();
      weightCon.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller: nameCon,
            decoration: InputDecoration(
              labelText: 'name',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: 'button3',
          child: Icon(Icons.save),
          splashColor: Colors.red,
          onPressed: () => add(),
        ),
      ],
    );
  }
}
