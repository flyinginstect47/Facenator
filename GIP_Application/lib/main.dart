import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gip_application/screens/edit_pf.dart';
import 'package:gip_application/screens/profile.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:gip_application/screens/menu.dart';
import 'package:gip_application/screens/sign_up.dart';

void main() {
  runApp(const App());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var email = prefs.getString('email');
//   print(email);
//   runApp(MaterialApp(home: email == null ? LogInPage() : HomePage()));
// }

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
        '/menu': (context) => const Menu(),
        '/SignIn': (context) => const SignUpPage(),
        '/EditPage': (context) => const EditPage(),
        '/ProfilePage': (context) => const ProfilePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/clinician_splash.png"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.pushNamed(context, "/menu");
    } else {
      Navigator.pushNamed(context, "/Login");
    }
  }
}
