import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final PictureController _cameracontrollerController = new PictureController();

  final ValueNotifier<double> _zoomNotifier = ValueNotifier(0);
  final ValueNotifier<Size> _photoSize = ValueNotifier(const Size(1920, 1080));
  final ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  final ValueNotifier<CaptureModes> _captureMode =
      ValueNotifier(CaptureModes.PHOTO);

  _onPermissionsResult(bool? granted) {
    if (granted != null) {
      if (!granted) {
        AlertDialog alert = AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'It seems you doesn\'t authorized some permissions. Please check on your settings and try again.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        setState(() {});
        print("granted");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CameraAwesome(
      onPermissionsResult: _onPermissionsResult,
      testMode: false,
      selectDefaultSize: (List<Size> availableSizes) => const Size(1910, 1070),
      onCameraStarted: () {},
      fitted: false,
      captureMode: _captureMode,
      photoSize: _photoSize,
      sensor: _sensor,
      zoom: _zoomNotifier,
    );
    //   return Scaffold(
    //     appBar: AppBar(title: const Text('Facenator')),
    //     // You must wait until the controller is initialized before displaying the
    //     // camera preview. Use a FutureBuilder to display a loading spinner until the
    //     // controller has finished initializing.
    //     body: FutureBuilder<void>(
    //       future: _initializeControllerFuture,
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           // If the Future is complete, display the preview.
    //           return CameraPreview(_controller);
    //         } else {
    //           // Otherwise, display a loading indicator.
    //           return const Center(child: CircularProgressIndicator());
    //         }
    //       },
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       // Provide an onPressed callback.
    //       onPressed: () async {
    //         // Take the Picture in a try / catch block. If anything goes wrong,
    //         // catch the error.
    //         try {
    //           // Ensure that the camera is initialized.
    //           await _initializeControllerFuture;

    //           // Attempt to take a picture and get the file `image`
    //           // where it was saved.
    //           final image = await _controller.takePicture();

    //           // If the picture was taken, display it on a new screen.
    //           await Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => DisplayPictureScreen(
    //                 // Pass the automatically generated path to
    //                 // the DisplayPictureScreen widget.
    //                 imagePath: image.path,
    //               ),
    //             ),
    //           );
    //         } catch (e) {
    //           // If an error occurs, log the error to the console.
    //           // ignore: avoid_print
    //           print(e);
    //         }
    //       },
    //       child: const Icon(Icons.camera_alt),
    //     ),
    //   );
    // }
  }

// A widget that displays the picture taken by the user.
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key? key, required this.imagePath})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Image.file(File(imagePath)),
//     );
//   }
}
