import 'package:flutter/material.dart';
import 'package:gip_application/screens/camera.dart';

// class Menu extends StatelessWidget {
//   const Menu({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    TakePictureScreen(),
    // Text(
    //   'Index 1: Business',
    //   style: optionStyle,
    // ),
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
      appBar: AppBar(
        title: const Text('Facenator'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_rounded),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
