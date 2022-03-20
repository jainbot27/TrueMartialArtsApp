import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:TMA/main.dart';
import 'package:TMA/event_list.dart'; 

class HomeScreen extends StatefulWidget {
  @override 
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; 
  final List _children = [
    EventList(), 
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pop();  
          },
        ),
        title: const Text('Calender of Events')
      ),      
      body: EventList(),     
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; 
    });
  }
}
