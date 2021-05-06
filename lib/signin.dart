import 'package:flutter/material.dart';
import 'package:namesclash/name.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesclash/splashscreen.dart';

import 'main.dart';

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "612757339681-u4kcl77t60vduifheh5do3fqspn4uor9.apps.googleusercontent.com");

  Widget _button(String textt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: MaterialButton(
        elevation: 0,
        height: 50,
        onPressed: () {
          startSignIn();
        },
        color: pc,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              textt,
              style: TextStyle(
                  fontSize: 24, color: Colors.white, fontFamily: 'Work Sans'),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              Image.asset(
                'assets/logo icon.png',
                height: 100,
              ),
              Text(
                'Names Clash',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28, color: Colors.white, fontFamily: 'Work Sans'),
              ),
              SizedBox(
                height: 300,
              ),
              _button('Sign In'),
              SizedBox(height: 20),
              Text(
                'By signing in you agree to our Terms\nand conditions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Work Sans'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startSignIn() async {
    await googleSignIn.signOut(); //optional
    var user = await googleSignIn.signIn();
    if (user == null) {
      print('Sign In failed');
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
