
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';


enum ThemeStyle {
  Dribbble,
  Light,
  NoElevation,
  AntDesign,
  BorderRadius,
  FloatingBar,
  NotificationBadge,
  WithTitle,
  BlurEffect
}

class New extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Navigation Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  ThemeStyle _currentStyle = ThemeStyle.WithTitle;

  List<int> _badgeCounts = List<int>.generate(4, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(4, (index) => true);

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[

    Text(
      'Index 1: Business',
      style: optionStyle,
    ),

    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      extendBody: true,
      backgroundColor: Colors.white,

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _buildTitle(),
    );
  }


  Widget _buildTitle() {
    return CustomNavigationBar(
        iconSize: 30.0,

        selectedColor:Colors.pink,
        strokeColor: Colors.pink,
        unSelectedColor: Colors.pink[200],

        backgroundColor: Colors.white,
        elevation: 5,
        items: [
          CustomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home" ,
              style: TextStyle(
                  color:  Colors.pink
              ),),

          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart",
              style: TextStyle(
                  color: Colors.pink
              ),),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            title: Text("Explore",
              style: TextStyle(
                  color: Colors.pink
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile",
              style: TextStyle(
                  color: Colors.pink
              ),),
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
    );
  }
}