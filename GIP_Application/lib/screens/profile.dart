import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:mysql1/mysql1.dart';

String id = ID;
String name = '';
String email = '';
String descrip = 'User';
String password = tempPassword;
String date = '';

// String pass = tempPassword;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  /*Future<String> sendUser(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectUser.php?id=$id";
    var response = await http.post(url, body: {});
    var data = await json.decode(response.body);
    name = data;
    return name;
  }
  Future<String> sendEmail(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectEmail.php?id=$id";
    var response = await http.post(url, body: {});
    var data = await json.decode(response.body);
    email = data;
    return email;
  }
  Future<String> sendDescrip(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectDescrip.php?id=$id";
    var response = await http.post(url, body: {});
    var data = await json.decode(response.body);
    if (data == "") {
    } else {
      descrip = data;
    }
    setState(() {});
    return descrip;
  }*/
  // ignore: prefer_typing_uninitialized_variables
  var conn;

  @override
  void initState() {
    super.initState();
    dbConnection();
    getInfo();
  }

  Future<void> dbConnection() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'ID191774_6itngip15.db.webhosting.be',
        port: 3306,
        user: 'ID191774_6itngip15',
        password: 'Zs21f5sdf5',
        db: 'ID191774_6itngip15'));
  }

  Future getInfo() async {
    String id = ID;
    // var url = Uri.parse("http://192.168.56.1/localconnect/SelectInfo.php?id=$id");
    // var response = await http.post(url, body: {});
    var response = await conn.query(
        'select username, password, email, Description, created from users where id=?',
        [id]);
    print(response);
    var data = response;
    final jsonData = jsonDecode(data);
    name = jsonData[0]["Username"];
    email = jsonData[0]["Email"];
    descrip = jsonData[0]["Description"];
    // password = jsonData[0]["Password"];
    date = jsonData[0]["Date"];
    // setState(() {});
    if (this.mounted) {
      setState(() {});
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    /*sendUser(context);
    sendEmail(context);
    sendDescrip(context);*/
    // getInfo(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  descrip,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.deepPurple,
                    child: const ListTile(
                      title: Text(
                        '69',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Nummerplaten gescand',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    'Naam',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    descrip,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Account aangemaakt: $date",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.purple,
                    ))
              ],
            )
          ])),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/EditPage");
                      },
                      color: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      color: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class LogIn extends StatefulWidget {
//   const LogIn({Key? key}) : super(key: key);

//   @override
//   State<LogIn> createState() => _LogInState();
// }

// class _LogInState extends State<LogIn> with TickerProviderStateMixin {
//   late AnimationController controller1;
//   late AnimationController controller2;
//   late Animation<double> animation1;
//   late Animation<double> animation2;
//   late Animation<double> animation3;
//   late Animation<double> animation4;

//   @override
//   void initState() {
//     super.initState();

//     controller1 = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         seconds: 5,
//       ),
//     );
//     animation1 = Tween<double>(begin: .1, end: .15).animate(
//       CurvedAnimation(
//         parent: controller1,
//         curve: Curves.easeInOut,
//       ),
//     )
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller1.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller1.forward();
//         }
//       });
//     animation2 = Tween<double>(begin: .02, end: .04).animate(
//       CurvedAnimation(
//         parent: controller1,
//         curve: Curves.easeInOut,
//       ),
//     )..addListener(() {
//         setState(() {});
//       });

//     controller2 = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         seconds: 5,
//       ),
//     );
//     animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
//       parent: controller2,
//       curve: Curves.easeInOut,
//     ))
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller2.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller2.forward();
//         }
//       });
//     animation4 = Tween<double>(begin: 170, end: 190).animate(
//       CurvedAnimation(
//         parent: controller2,
//         curve: Curves.easeInOut,
//       ),
//     )..addListener(() {
//         setState(() {});
//       });

//     Timer(const Duration(milliseconds: 2500), () {
//       controller1.forward();
//     });

//     controller2.forward();
//   }

//   @override
//   void dispose() {
//     controller1.dispose();
//     controller2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: ScrollConfiguration(
//         behavior: MyBehavior(),
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: size.height,
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: size.height * (animation2.value + .58),
//                   left: size.width * .21,
//                   child: CustomPaint(
//                     painter: MyPainter(50),
//                   ),
//                 ),
//                 Positioned(
//                   top: size.height * .98,
//                   left: size.width * .1,
//                   child: CustomPaint(
//                     painter: MyPainter(animation4.value - 30),
//                   ),
//                 ),
//                 Positioned(
//                   top: size.height * .5,
//                   left: size.width * (animation2.value + .8),
//                   child: CustomPaint(
//                     painter: MyPainter(30),
//                   ),
//                 ),
//                 Positioned(
//                   top: size.height * animation3.value,
//                   left: size.width * (animation1.value + .1),
//                   child: CustomPaint(
//                     painter: MyPainter(60),
//                   ),
//                 ),
//                 Positioned(
//                   top: size.height * .1,
//                   left: size.width * .8,
//                   child: CustomPaint(
//                     painter: MyPainter(animation4.value),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget component1(
//       IconData icon, String hintText, bool isPassword, bool isEmail) {
//     Size size = MediaQuery.of(context).size;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaY: 15,
//           sigmaX: 15,
//         ),
//         child: Container(
//           height: size.width / 8,
//           width: size.width / 1.2,
//           alignment: Alignment.center,
//           padding: EdgeInsets.only(right: size.width / 30),
//           decoration: BoxDecoration(
//             color: Colors.indigoAccent.withOpacity(.05),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: TextField(
//             style: TextStyle(color: Colors.white.withOpacity(.8)),
//             cursorColor: Colors.white,
//             obscureText: isPassword,
//             keyboardType:
//                 isEmail ? TextInputType.emailAddress : TextInputType.text,
//             decoration: InputDecoration(
//               prefixIcon: Icon(
//                 icon,
//                 color: Colors.white.withOpacity(.7),
//               ),
//               border: InputBorder.none,
//               hintMaxLines: 1,
//               hintText: hintText,
//               hintStyle:
//                   TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget component2(String string, double width, VoidCallback voidCallback) {
//     Size size = MediaQuery.of(context).size;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
//         child: InkWell(
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onTap: voidCallback,
//           child: Container(
//             height: size.width / 8,
//             width: size.width / width,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(.05),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Text(
//               string,
//               style: TextStyle(color: Colors.white.withOpacity(.8)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//         .add(DiagnosticsProperty<Animation<double>>('animation3', animation3));
//   }
// }

// class Fluttertoast {
//   static void showToast({String? msg}) {}
// }

// class MyPainter extends CustomPainter {
//   final double radius;

//   MyPainter(this.radius);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..shader = const LinearGradient(
//               colors: [Color(0xFFD1C4E9), Color(0x3DFFFFFF)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight)
//           .createShader(Rect.fromCircle(
//         center: const Offset(0, 0),
//         radius: radius,
//       ));

//     canvas.drawCircle(Offset.zero, radius, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
