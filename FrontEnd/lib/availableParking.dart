import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AvailableParking extends StatefulWidget {
  AvailableParking({Key key}) : super(key: key);

  _AvailableParkingState createState() => _AvailableParkingState();
}

class _AvailableParkingState extends State<AvailableParking> {
  int booked;
  int available;
  int total;
  Timer timer;
  int n = 1;
  Image cameraImage = Image.network("http://hughboy.com:9999/img.png");

  void updateData() async {
    final http.Response response = await http.get(
        "http://hughboy.com:9999/number",
        headers: {"Content-Type": "application/json"});
    if (this.mounted) {
      setState(() {
        booked = int.parse(response.body);
        available = total - booked;
        imageCache.clear();
        n += 1;
        cameraImage =
            Image.network("http://hughboy.com:9999/img.png?k=" + n.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    booked = 0;
    total = 18;
    available = total - booked;
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => updateData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Spots"),
      ),
      body: Center(
        child: Container(
            child: ListView(
          children: <Widget>[
            Text("            Available Spots: $available",
                style: TextStyle(fontSize: 25, color: Colors.green)),
            cameraImage,
            Text("            Total Spots: $total",
                style: TextStyle(fontSize: 25, color: Colors.blue)),
          ],
        )),
      ),
    );
  }
}
