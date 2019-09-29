import 'package:flutter/material.dart';
import 'infoPage.dart';
import './register.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login to Park Spot")),
        body: Center(
          child: Container(
              child: Column(
            children: <Widget>[
              Spacer(flex: 1),
              ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  child: RaisedButton(
                    child: Text("Login", style: TextStyle(fontSize: 40)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  )),
              Spacer(flex: 1),
              ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  child: RaisedButton(
                    child: Text("Register", style: TextStyle(fontSize: 40)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )),
              Spacer(flex: 1)
            ],
          )),
        ));
  }
}
