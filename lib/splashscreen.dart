import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesclash/main.dart';
import 'package:namesclash/signin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "612757339681-u4kcl77t60vduifheh5do3fqspn4uor9.apps.googleusercontent.com");
  @override
  void initState() {
    checkSignInStatus();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                height: 30,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 2));
    bool isSignedIn = await googleSignIn.isSignedIn();
    bool ok = true;
    if (isSignedIn) {
      print('USer signed in');
      if (ok) {
        Navigator.pushReplacementNamed(context, '/name');
      } else {
        Navigator.pushReplacementNamed(context, '/profile');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/MySignInPage');
    }
    ok = false;
  }
}
