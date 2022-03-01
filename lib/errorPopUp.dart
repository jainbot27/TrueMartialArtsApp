import 'package:flutter/material.dart';

void createError(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: false, // disables popup to close if tapped outside popup (need a button to close)
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!',),
          content: Text(text),
          //buttons?
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () { Navigator.of(context).pop(); }, //closes popup
            ),
          ],
        );
      }
    );
}