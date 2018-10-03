import 'package:apfptpoly/widgets/custom_dialog.dart';
import 'package:flutter/material.dart' hide AlertDialog, Dialog;

class AlertMessage extends StatelessWidget {
  final String title;
  final String content;

  const AlertMessage({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
