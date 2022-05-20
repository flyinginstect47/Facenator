import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gip_application/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gip_application/screens/login_page.dart';

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

  /*Future sendUser(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectUser.php?id=$id";
    var response = await http.post(url, body: {});

    var data = await json.decode(response.body);
    name = data;
    return name;
  }

  Future sendEmail(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectEmail.php?id=$id";
    var response = await http.post(url, body: {});

    var data = await json.decode(response.body);
    email = data;
    return email;
  }

  Future sendDescrip(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectDescrip.php?id=$id";
    var response = await http.post(url, body: {});

    var data = await json.decode(response.body);
    descrip = data;
    return descrip;
  }

  Future sendPass(BuildContext cont) async {
    var url = "http://192.168.56.1/localconnect/SelectPass.php?id=$id";
    var response = await http.post(url, body: {});

    var data = await json.decode(response.body);
    password = data;
    return password;
  }*/

  // Future getInfo(BuildContext cont) async {
  //   var url = "http://192.168.56.1/localconnect/SelectInfo.php?id=$id";
  //   var response = await http.post(url, body: {});

  //   var data = await response.body;
  //   final jsonData = jsonDecode(data);
  //   name = jsonData[0]["Username"];
  //   email = jsonData[0]["Email"];
  //   descrip = jsonData[0]["Description"];
  //   password = jsonData[0]["Password"];
  //   // setState(() {
  //   //   loading = false;
  //   // });
  //   return;
  // }

  late FToast fToast;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
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
          children: [
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
    // if (loading) return CircularProgressIndicator();
    // getInfo(context);
    /*sendUser(context);
    sendEmail(context);
    sendDescrip(context);
    sendPass(context);*/
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
    var url = Uri.parse("http://192.168.56.1/localconnect/EditUser.php?id=$id");
    var response = await http.post(url, body: {
      "id": id,
      "username": name,
      "Description": descrip,
      "email": email,
      "password": password,
    });

    var data = await json.decode(response.body);

    if (data == "success") {
      Navigator.pop(context);
    }
  }
}
