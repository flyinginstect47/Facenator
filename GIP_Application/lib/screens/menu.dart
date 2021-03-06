import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/camera.dart';
import 'package:gip_application/screens/home.dart';
import 'package:gip_application/screens/profile.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  int _selectedIndex = 0;
  late CameraDescription cameraDescription;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const Home(),
      TakePictureScreen(camera: widget.camera),
      const ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carlicious'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
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
