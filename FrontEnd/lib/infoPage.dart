import 'package:flutter/material.dart';
import "./availableParking.dart";

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse('FF' + hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text("Parkinator Home"),
        ),
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
                image: AssetImage('./assets/dummyParking.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Spacer(flex: 1),
                  RaisedButton(
                    child: Text("View Footage of Lot 50"),
                    color: Colors.black38,
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
                    color: Colors.black38,
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
                    color: Colors.black38,
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
                    color: Colors.black38,
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
                    color: Colors.black38,
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
                    color: Colors.black38,
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
        )));
  }
}
