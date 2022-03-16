import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:csia/main.dart';

class HomeScreen extends StatefulWidget {
  @override 
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedDay; 
  DateTime _focusedDay = DateTime.now(); 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calender of Events DEBUG')),      
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay; 
            _focusedDay = focusedDay; 
            
          });
        },
      )
    );
  }
}
