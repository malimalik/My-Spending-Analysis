import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.purple,
            onPressed: handler,
            child: Text(text),
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(text),
            onPressed: handler,
          );
  }
}
