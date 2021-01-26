import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'exercise.dart';

class Storage extends StatefulWidget {
  final Box box;
  Storage(this.box);

  @override
  State<StatefulWidget> createState() {
    return _StorageState(box);
  }
}

class _StorageState extends State<Storage> {
  final Box box;
  _StorageState(this.box);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            "One rep Maxes",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            final exercise = box.getAt(index) as Exercise;

            return ListTile(
              title: Text(exercise.name),
              subtitle: Text(exercise.weight.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  box.deleteAt(index);
                  setState(() {});
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
