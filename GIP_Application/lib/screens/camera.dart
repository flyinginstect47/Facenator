import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late var conn;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  StreamController<String> controller = StreamController<String>();
  late Stream stream;

  @override
  void initState() {
    super.initState();
    // Get a specific camera from the list of available cameras.
    // final firstCamera = cameras.first;
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    stream = controller.stream;
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            var url =
                Uri.parse('https://api.platerecognizer.com/v1/plate-reader/');
            var img = File(image.path).readAsBytesSync();
            String base64 = base64Encode(img);
            var response = await http.post(url, body: {
              "upload": base64,
              "regions": "be"
            }, headers: {
              "Authorization": "Token dcf41504e2f27f0d581fe9a8370dc67b888ad313"
            });
            final Map<String, dynamic> data = json.decode(response.body);
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                  response: data,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final Map<String, dynamic> response;
  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.response})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  var conn;

  @override
  void initState() {
    dbConnection();
  }

  Future<void> dbConnection() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'ID191774_6itngip15.db.webhosting.be',
        port: 3306,
        user: 'ID191774_6itngip15',
        password: 'Zs21f5sdf5',
        db: 'ID191774_6itngip15'));
    var result = await conn.query(
        'insert into tbl_numberplates (numberplate, timestamp) values (?, ?)',
        [Autogenerated.fromJson(widget.response).results!.toString(), Autogenerated.fromJson(widget.response).timestamp.toString()]);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.file(
                File(widget.imagePath),
                height: 300,
              ),
              Text("Plate: " +
                  Autogenerated.fromJson(widget.response).results!.toString() +
                  "\n Timestamp: " +
                  Autogenerated.fromJson(widget.response).timestamp.toString()),
            ]));
  }
}

class Autogenerated {
  double? processingTime;
  List<Results>? results;
  String? timestamp;

  Autogenerated({this.processingTime, this.results, this.timestamp});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    processingTime = json['processing_time'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processing_time'] = this.processingTime;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Results {
  String? plate;
  double? score;

  Results({
    this.plate,
    this.score,
  });

  Results.fromJson(Map<String, dynamic> json) {
    plate = json['plate'];
    score = json['score'];
    if (json['candidates'] != null) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate'] = this.plate;
    data['score'] = this.score;
    return data;
  }

  @override
  String toString() {
    return plate!;
  }
}
