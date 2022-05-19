import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gip_application/screens/camera.dart';
// import 'package:gip_application/screens/Home_Page.dart';

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

  Future getInfo(BuildContext cont) async {
    String id = ID;
    var url = "http://192.168.56.1/localconnect/SelectInfo.php?id=$id";
    var response = await http.post(url, body: {});

    var data = response.body;
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
    getInfo(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  descrip,
                  style: TextStyle(
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
                    child: ListTile(
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
                  title: Text(
                    'Naam',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    email,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    descrip,
                    style: TextStyle(
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
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.purple,
                    ))
              ],
            )
          ])),
          Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
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
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
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
