import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:csia/main.dart';
import 'package:csia/calendar.dart'; 
import 'package:csia/events.dart'; 

class HomeScreen extends StatefulWidget {
  @override 
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; 
  final List _children = [
    Calendar(), 
    Event(), 
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
        title: const Text('Calender of Events DEBUG')
      ),      
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: onTabTapped, 
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_month_sharp),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon:  new Icon(Icons.list),
            label: 'Events'
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; 
    });
  }
}
