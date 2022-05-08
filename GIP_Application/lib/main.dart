import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:gip_application/screens/menu.dart';
import 'package:gip_application/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(App(camera: firstCamera));
}

class App extends StatefulWidget {
  const App({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Get rid of debug Logo in corner
      debugShowCheckedModeBanner: false,
      title: 'Facenator',
      initialRoute: '/',
      routes: {
        '/': (context) => const LogInPage(),
        '/login': (context) => const LogInPage(),
        '/menu': (context) => Menu(camera: widget.camera),
        '/loginpage': (context) => const LogIn(),
      },
    );
  }
}
