import 'package:flutter/material.dart';

import './successPage.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Builder(
              builder: (context) => Form(
                    //user this like a post request
                    key: _formKey,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //name
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'First Name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your First Name!';
                                }
                                return "";
                              }),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Last Name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Last Name!';
                                }
                                return "";
                              }),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid email address!';
                                }
                                return "";
                              }),
                          //password
                          TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a password!';
                                }
                                return "";
                              },
                              obscureText: true),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password mismatch!';
                                }
                                return "";
                              },
                              obscureText: true),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 16.0,
                              ),
                              child: RaisedButton(
                                onPressed: () {
                                  final form = _formKey.currentState;
                                  if (form.validate()) {
                                    //form.save();
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Success()));
                                },
                                child: Text('Register'),
                              )),
                        ],
                      ),
                    ),
                  ))),
    ));
  }
}
