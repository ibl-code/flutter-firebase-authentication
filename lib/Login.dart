import 'package:flutter/material.dart';
import 'Global.dart';
import 'Registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _loginPage();
}

class _loginPage extends State<loginPage> {
  final emailId = TextEditingController();
  final password = TextEditingController();
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
    if (emailId.text == "" && password.text == "") {
      _showAlert("Enter All Infomation");
    } else if (emailId.text == "") {
      _showAlert("Please Enter email Id");
    } else if (password.text == "") {
      _showAlert("Please Enter Password");
    } else {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailId.text, password: password.text);
        _showAlert("Login Successfull");

        print(user);
        print(user.uid);
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString("userToken", user.uid);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => Home(),
        //     ),
        //     ModalRoute.withName('/Home'));
      } catch (e) {
        print("error");
        print(e.message);
        _showAlert("User Not Exist.Please enter correct Detail.");
      }
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: appColor,
      ),
      resizeToAvoidBottomPadding: false,
      body: new Container(
          padding: new EdgeInsets.only(left: 30, right: 30),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  controller: emailId,
                  decoration: new InputDecoration(
                    hintText: "Email Id",
                    labelText: "Email Id",
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                new TextField(
                  obscureText: true,
                  controller: password,
                  decoration: new InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
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
                        style:
                            new TextStyle(fontSize: 20, color: Colors.white)),
                    color: appColor,
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Registration(),
                        ));
                  },
                  child: new Text(
                    "Create Account?",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ])),
    );
  }
}
