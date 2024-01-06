import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String text;
  final Function handler;

  AddButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return
         CupertinoButton(
      child: Text(text),
      onPressed: handler(),
    );
  }
}