
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:csia/main.dart';

class AdminScreen extends StatefulWidget {
  @override 
  AdminScreenState createState() => AdminScreenState();
}
class AdminScreenState extends State<AdminScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calender of Events')),      
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
      )
    );
  }
}