import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gip_application/screens/login_page.dart';
import 'package:mysql1/mysql1.dart';
import 'package:crypto/crypto.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPage();
}

String id = ID;
String tempname = '';
String tempemail = '';
String tempdescrip = '';
String temppassword = '';

void getInfo() {
  id = ID;
  tempname = name;
  tempemail = email;
  tempdescrip = descrip;
  temppassword = password;
}

bool _passwordVisible = false;

class _EditPage extends State<EditPage> with TickerProviderStateMixin {
  TextEditingController username = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController emails = TextEditingController();
  TextEditingController pass = TextEditingController();

  late FToast fToast;

  var conn;

  Future<void> dbConnection() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'ID191774_6itngip15.db.webhosting.be',
        port: 3306,
        user: 'ID191774_6itngip15',
        password: 'Zs21f5sdf5',
        db: 'ID191774_6itngip15'));
    getUser();
  }

  Future getUser() async {
    var response = await conn.query(
        'select username, password, email, Description, created from users where id=?',
        [id]);
    List list = [];
    for (var row in response) {
      Elem e = Elem();
      e.name = row[0];
      e.email = row[2];
      e.descrip = row[3];
      // e.password = row[1];
      list.add(e);
    }
    tempname = list[0].name;
    tempemail = list[0].email;
    tempdescrip = list[0].descrip;
    setState(() {});
    return;
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
    dbConnection();
    print(tempdescrip);
    fToast = FToast();
    fToast.init(context);
    _showToast() {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.indigoAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check),
            SizedBox(
              width: 10.0,
            ),
            Text("Aanpassingen doorgevoerd!"),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
      );
    }
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    getInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.purple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.purple,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", tempname, false),
              buildTextField1("E-mail", tempemail, false),
              buildTextField2("Description", tempdescrip, false),
              buildTextField3("Password", temppassword, true),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: deprecated_member_use
                  OutlineButton(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      uploaddata(context);
                      // Navigator.pushNamed(context, "/ProfilePage");
                    },
                    color: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: username..text = placeholder,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField1(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: emails..text = placeholder,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField2(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: description..text = placeholder,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextField3(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: pass..text = placeholder,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = true;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            )),
      ),
    );
  }

  Future uploaddata(BuildContext cont) async {
    name = username.text;
    descrip = description.text;
    email = emails.text;
    password = pass.text;
    var hash = md5.convert(utf8.encode(pass.text));

    var response = await conn.query(
        'UPDATE `users` SET `username`=?,`Description`=?,`Email`=?,`password`=? WHERE id=?',
        [name, descrip, email, hash.toString(), ID]);

    if (response != null) {
      Navigator.pushNamed(context, "/menu");
    }
  }
}

class Elem {
  String name;
  String email;
  String descrip;
  String password;

  Elem({
    this.name = "",
    this.email = "",
    this.descrip = "",
    this.password = "",
  });
}
