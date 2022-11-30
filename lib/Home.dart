import 'package:f1/Buscar.dart';
import 'package:f1/HomePage.dart';
import 'package:f1/Lan%C3%A7ar.dart';
import 'package:f1/Listar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var _collorIconBottomBar = Colors.white;
  var _collorIconBottomBarDefault = Colors.grey;


  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Lancar(),
    Listar(),
    Buscar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file),
              label: "Lançar",
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(icon: Icon(Icons.list),
              label: "Listar",
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(icon: Icon(Icons.search),
              label: "Buscar",
              backgroundColor: Colors.blueAccent)
        ],
        selectedItemColor: _collorIconBottomBar,
        unselectedItemColor: Colors.black45,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
