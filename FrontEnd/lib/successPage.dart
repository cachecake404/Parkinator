import 'package:flutter/material.dart';

import './loginPage.dart';

class Success extends StatelessWidget {
  const Success({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Registration Completion")),
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                  image: AssetImage('./assets/regist.png'), fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text("Registration Successful!",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
                RaisedButton(
                  child: Text("Back to Login"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                )
              ],
            )));
  }
}
