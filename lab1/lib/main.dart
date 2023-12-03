import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SubjectListScreen(),
    );
  }
}

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({super.key});

  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  List<String> subjects = [];

  void addSubject(){
    showDialog(context: context, builder: (BuildContext context) {
      String newSubject = "";
      return AlertDialog(
        title: const Text("Add a new subject"),
        content: TextField(
          onChanged: (value) {
            newSubject = value;
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                if(newSubject.isNotEmpty) {
                  subjects.add(newSubject);
                }
                Navigator.pop(context);
              });
            }, 
            child: const Text("Add"))
        ]
      );
  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("201511 Lab1"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
          itemBuilder: (context, index){
            return Card (
              child: ListTile( 
                title: Text(subjects[index], style: const TextStyle(fontSize: 18)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_rounded), onPressed: () {  
                    setState(() {
                      subjects.removeAt(index);
                    });
                },),
              )
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: addSubject, 
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_box_outlined),
      ),
    ); 
  }
}