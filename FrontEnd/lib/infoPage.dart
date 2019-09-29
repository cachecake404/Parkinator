import 'package:flutter/material.dart';
import "./availableParking.dart";

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  _InfoPageState createState() => _InfoPageState();
}
///HAHAHA
class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Park Spot"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                "Welcome to Park Spot",
                style: TextStyle(fontSize: 35, color: Colors.red[300]),
              ),
              Spacer(flex: 1),
              RaisedButton(
                child: Text("View Footage of Lot 50"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AvailableParking()));
                },
              ),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {},
                child: Text("View Footage of Lot 26"),
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AvailableParking()));
                // },
              ),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {},
                child: Text("View Footage of Lot 55"),
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AvailableParking()));
                // },
              ),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {},
                child: Text("View Footage of Lot F10"),
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AvailableParking()));
                // },
              ),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {},
                child: Text("View Footage of Lot 36"),
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AvailableParking()));
                // },
              ),
              Spacer(flex: 1),
              RaisedButton(
                onPressed: () {},
                child: Text("View Footage of Lot F7"),
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AvailableParking()));
                // },
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    ));
  }
}
