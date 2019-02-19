import 'package:flutter/material.dart';
import 'Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';

class Registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _Registration();
}

class _Registration extends State<Registration> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final confPassword = TextEditingController();
  final email = TextEditingController();
  final birthDate = TextEditingController();
  final address = TextEditingController();
  String validEmail = "";
  var validPass = "";
  var validPass1 = "";

  validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      setState(() {
        validEmail = "Enter Valid Email";
      });
    } else {
      setState(() {
        validEmail = "";
      });
    }
  }

  validPassword1(var value) {
    if (value.length < 6) {
      setState(() {
        validPass1 = "Password must be at least 6 characters";
      });
    } else {
      print("right");

      setState(() {
        validPass1 = "";
      });
    }
  }

  validPassword(String value) {
    if (password.text == value) {
      setState(() {
        validPass = "";
      });
    } else {
      setState(() {
        validPass = "Not Match";
      });
    }
  }

  void _showAlert(String value) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Alert!"),
              content: Text(value),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "Ok",
                    style: TextStyle(fontSize: 20, color: appColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _submit() async {
    if (userName.text == "" &&
        password.text == "" &&
        confPassword.text == "" &&
        email.text == "") {
      _showAlert("Enter All Infomation");
    } else if (userName.text == "") {
      _showAlert("Please Enter userName");
    } else if (password.text == "") {
      _showAlert("Please Enter Password");
    } else if (confPassword.text == "") {
      _showAlert("Please Enter Confirm Password");
    } else if (email.text == "") {
      _showAlert("Please Enter Email Id");
    } else {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        print(user);
        print(user.uid);
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString("userToken", user.uid);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => loginPage(),
            ),
            ModalRoute.withName('/loginPage'));
      } catch (e) {
        print("error");
        print(e.message);
        _showAlert(e.message);
      }
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Registration Page"),
          backgroundColor: appColor,
        ),
        body: new ListView(children: <Widget>[
          new Container(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding:
                          new EdgeInsets.only(top: 20, left: 10.0, right: 10),
                    ),
                    new TextField(
                      controller: userName,
                      textInputAction: TextInputAction.done,
                      decoration: new InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: appColor,
                          ),
                          hintText: 'UserName',
                          labelText: 'userName'),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                    ),
                    new TextField(
                      obscureText: true,
                      controller: password,
                      onChanged: (value) {
                        validPassword1(value);
                      },
                      decoration: new InputDecoration(
                        icon: Icon(Icons.lock, color: appColor),
                        hintText: "Password",
                        labelText: "Password",
                      ),
                    ),
                    new Text(validPass1,
                        style: new TextStyle(color: Colors.red)),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                    ),
                    new TextField(
                      obscureText: true,
                      controller: confPassword,
                      onChanged: (value) {
                        validPassword(value);
                      },
                      decoration: new InputDecoration(
                        icon: Icon(Icons.lock, color: appColor),
                        hintText: "confirm Password",
                        labelText: "confirm Password",
                      ),
                    ),
                    new Text(validPass,
                        style: new TextStyle(color: Colors.red)),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                    ),
                    new TextField(
                      controller: email,
                      onChanged: (value) {
                        validateEmail(value);
                      },
                      decoration: new InputDecoration(
                        icon: Icon(Icons.email, color: appColor),
                        hintText: "Email",
                        labelText: "Email",
                      ),
                    ),
                    new Text("$validEmail",
                        style: TextStyle(color: Colors.red)),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.0),
                    ),
                    new TextField(
                      controller: address,
                      maxLines: 2,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.home, color: appColor),
                        hintText: "Address",
                        labelText: "Address",
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 30.0),
                    ),
                    ButtonTheme(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      minWidth: 300.0,
                      height: 50.0,
                      child: RaisedButton(
                        child: new Text("Submit",
                            style: new TextStyle(
                                fontSize: 20, color: Colors.white)),
                        color: appColor,
                        onPressed: () {
                          _submit();
                        },
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 30.0),
                    ),
                  ])),
        ]));
  }
}
