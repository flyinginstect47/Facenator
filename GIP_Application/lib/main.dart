import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:gip_application/screens/menu.dart';
import 'package:gip_application/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Obtain a list of the available cameras on the device.

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
        '/menu': (context) => const Menu(),
        '/loginpage': (context) => const LogIn(),
      },
    );
  }
}
