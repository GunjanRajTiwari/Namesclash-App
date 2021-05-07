import 'package:flutter/material.dart';
import 'package:namesclash/name.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesclash/splashscreen.dart';
import 'package:namesclash/signin.dart';
import 'package:namesclash/main.dart';
import 'package:namesclash/inputbox.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "612757339681-u4kcl77t60vduifheh5do3fqspn4uor9.apps.googleusercontent.com");
  GoogleSignInAccount account;
  GoogleSignInAuthentication auth;
  bool gotProfilee = false;

  String name = TextEditingController().text;
  Widget _button(String textt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: MaterialButton(
        elevation: 0,
        height: 50,
        onPressed: () {
          // if (showValue) {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (_) => NamePage()));
          // }
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
            //Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    gotProfile();
  }

  @override
  Widget build(BuildContext context) {
    return gotProfilee
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: bg2,
              title: Text(
                'Profile',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              actions: [],
            ),
            backgroundColor: bg,
            body: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    Image.network(
                      account.photoUrl,
                      height: 100,
                    ),
                    Text(
                      account.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Work Sans'),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    _button('Chat'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        : LinearProgressIndicator();
  }

  void gotProfile() async {
    account = googleSignIn.currentUser;
    auth = await account.authentication;
    setState(() {
      gotProfilee = true;
    });
  }
}
