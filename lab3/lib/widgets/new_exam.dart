import 'dart:math';

import 'package:flutter/material.dart';

import 'package:lab3/model/Exam.dart';

import 'add_button.dart';

class NewExam extends StatefulWidget {
  final Function addItem;

  NewExam(this.addItem);
  @override
  State<StatefulWidget> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  late String title;
  late DateTime date;
  late DateTime time;

  var _chars = 'Beyza201511';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  void _submitData() {
    if (_dateController.text.isEmpty) {
      return;
    }

    final newTitle = _titleController.text;
    final newDate = DateTime.parse(_dateController.text);
    final newTime = DateTime.parse(_timeController.text);

    if (newTitle.isEmpty) {
      return;
    }

    final newItem = Exam(id: getRandomString(10), title: newTitle, date: newDate, time: newTime );
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: "Title of Exam"),
             onChanged: (val) {
               title = val;
             },
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: "Date Of Exam"),
            keyboardType: TextInputType.datetime,
             onChanged: (val) {
               date = DateTime.parse(val);
             }
          ),
          TextField(
            controller: _timeController,
            decoration: InputDecoration(labelText: "Time Of Exam"),
            keyboardType: TextInputType.datetime,
             onChanged: (val) {
               time = DateTime.parse(val);
             },
            onSubmitted: (_) => _submitData(),
          ),
          AddButton("Add Exam", _submitData)
        ],
      ),
    );
  }
}