import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab3/widgets/add_button.dart';
import 'model/Exam.dart';
import 'widgets/new_exam.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Exam> _examItems = [
    Exam(id: "Subject1", title: "Mobile App in Flutter",
        date: DateTime.now(), time: DateTime.now()),
    Exam(id: "Subject2", title: "Operating Systems",
        date: DateTime.now(), time: DateTime.now()),
  ];

  void _addExamFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(onTap: () {}, behavior: HitTestBehavior.opaque, child: NewExam(_addNewExamToList));
        });
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  void _addNewExamToList(Exam examItem) {
    setState(() {
      _examItems.add(examItem);
    });
  }


  Widget _createBody() {
    return Center(
      child: _examItems.isEmpty
          ? Text("No elements")
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            child: ListTile(
              title: Text(_examItems[index].title),
              subtitle: Text("${_examItems[index].date} ${_examItems[index].time}"),
            ),
          );
        },
        itemCount: _examItems.length,
      ),
    );
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      // The title text which will be shown on the action bar
        title: Text("List of Exams"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addExamFunction(context),
          ),
          AddButton(
              'Logout',
              _signOut
          ),
        ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
    );
  }

}
