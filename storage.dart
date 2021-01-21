import 'package:weight_planner_app/adder.dart';
import 'relativeInt.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'exercise.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final directory = await pathProvider.getApplicationDocumentsDirectory();
//   Hive.init(directory.path);
//   Hive.registerAdapter(ExerciseAdapter());
//   runApp(
//     MaterialApp(
//       home: FutureBuilder(
//         future: Hive.openBox('exercises'),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError)
//               return Text(snapshot.error.toString());
//             else
//               return Storage();
//           }
//           // Although opening a Box takes a very short time,
//           // we still need to return something before the Future completes.
//           else
//             return Scaffold();
//         },
//       ),
//     ),
//   );
// }

ListView _buildListView() {
  final exerciseBox = Hive.box('exercises');
  return ListView.builder(
    itemCount: exerciseBox.length,
    itemBuilder: (BuildContext context, int index) {
      final exercise = exerciseBox.get(index) as Exercise;

      return ListTile(
        title: Text(exercise.name),
        subtitle: Text(exercise.weight.toString()),
      );
    },
  );
}

class Storage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StorageState();
  }
}

class _StorageState extends State<Storage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "One rep Maxes",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 600,
                child: _buildListView(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(16),
              child: Adder(),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                child: Text("One Rep Max"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Max(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                child: Text("Relative Int"),
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
          ],
        ),
      ),
    );
  }
}
