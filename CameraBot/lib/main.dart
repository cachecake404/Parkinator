import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import "dart:convert";
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import "package:http/http.dart" as http;

int botCamClickSec = 3;
int botSwitchView = 2;
String apiUrl = "http://www.hughboy.com:9999/";

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  String appBarTitle = "Bot is Active";
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    // Timer.periodic(
    //     Duration(seconds: botCamClickSec), (Timer t) => takePic(context));
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void enableBot(BuildContext context) {
    // setState(() {
    //   if (appBarTitle == "Bot Inactive") {
    //     appBarTitle = "Bot is Active";
    //     takePic(context);
    //   } else {
    //     appBarTitle = "Bot Inactive";
    //   }
    // });
    takePic(context);
  }

  void takePic(BuildContext context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    if (appBarTitle == "Bot is Active") {
      try {
        // Ensure that the camera is initialized.
        await _initializeControllerFuture;

        // Construct the path where the image should be saved using the
        // pattern package.
        final path = join(
          // Store the picture in the temp directory.
          // Find the temp directory using the `path_provider` plugin.
          (await getTemporaryDirectory()).path,
          '${DateTime.now()}.png',
        );

        // Attempt to take a picture and log where it's been saved.
        await _controller.takePicture(path);

        // If the picture was taken, display it on a new screen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: path),
          ),
        );
      } catch (e) {
        // If an error occurs, log the error to the console.
        print(e);
      }
    } else {
      print("NOT TAKING PICTURES NOT BOT IS INACTIVE!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // Provide an onPressed callback.
          onPressed: () {
            enableBot(context);
          }),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  Timer timer;

  void startTimer(BuildContext context) {
    timer.cancel();
    Navigator.pop(context);
  }

  Future<void> postPicture(File file) async {
    String base64Image = base64Encode(file.readAsBytesSync());
    Firestore.instance
        .collection('images')
        .document("lotOne")
        .setData({"imageData": base64Image});
  }

  // Future<void> postPicture(File imageFile, String endPoint) async {

  //   // open a bytestream
  //   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   // get file length
  //   var length = await imageFile.length();
  //   print(length);

  //   // string to uri
  //   var uri = Uri.parse(apiUrl+endPoint+".jpg");

  //   // create multipart request
  //   var request = new http.MultipartRequest("POST", uri);

  //   // multipart that takes file
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));

  //   // add file to multipart
  //   request.files.add(multipartFile);

  //   // send
  //   var response = await request.send();
  //   print(response.statusCode);

  //   // listen for response
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    File imgFile = File(widget.imagePath);
    postPicture(imgFile);
    timer = Timer.periodic(
        Duration(seconds: botSwitchView), (Timer t) => startTimer(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath)),
    );
  }
}
