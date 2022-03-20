import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  @override 
  _ButtonState createState() => _ButtonState(); 
}

Icon icon1 = Icon(CupertinoIcons.bell);
Icon icon2 = Icon(CupertinoIcons.bell_fill);

class _ButtonState extends State<Button> {
  List<Icon> lst = [icon1, icon2];
  int idx = 0; 
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed:() {
        setState(() {
            idx ^= 1;  
        });
      },
      child: lst[idx], 
    );
  }
}
// Icon icon1 = const Icon(CupertinoIcons.bell);
// Icon icon2 = const Icon(CupertinoIcons.bell_fill);