import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesclash/main.dart';
import 'package:namesclash/inputbox.dart';
import 'package:namesclash/signin.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "612757339681-u4kcl77t60vduifheh5do3fqspn4uor9.apps.googleusercontent.com");
  GoogleSignInAccount account;
  String _name;

  Widget _button(String textt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: MaterialButton(
        elevation: 0,
        height: 50,
        onPressed: () {
          if (showValue) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => NamePage()));
          }
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

  // Widget _buildName() {
  //   Color bg2 = Color(0xFF3C4455);
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     child: TextFormField(
  //       maxLines: 1,
  //       style: TextStyle(
  //           color: Colors.white, fontSize: 32, fontFamily: 'Work Sans'),
  //       decoration: InputDecoration(
  //         labelText: 'Name',
  //         fillColor: Colors.white,
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: Colors.white, width: 2.0),
  //           borderRadius: BorderRadius.circular(25.0),
  //         ),
  //       ),
  //       validator: (String value) {
  //         if (value.isEmpty) {
  //           return 'Name can\'t be empty';
  //         }
  //         return null;
  //       },
  //       onSaved: (String value) {
  //         _name = value;
  //       },
  //     ),
  //   );
  // }

  bool showValue = false;
  GoogleSignInAuthentication auth;
  bool gotProfile = false;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return gotProfile
        ? Scaffold(
            backgroundColor: bg,
            body: SafeArea(
              //padding: const EdgeInsets.all(8.0),
              child: Center(
                //margin: EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo icon.png',
                      height: 50,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Enter Your First Name:',
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Work Sans',
                          color: Colors.white),
                    ),
                    //_buildName(),
                    InputBox(
                      maxLines: 1,
                    ),
                    SizedBox(height: 60.0),
                    CheckboxListTile(
                      title: Text(
                        "I agree that this is my real name.",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Work Sans',
                            color: Colors.white),
                      ),
                      value: this.showValue,
                      onChanged: (bool value) {
                        setState(() {
                          this.showValue = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    _button('Enter'),
                  ],
                ),
              ),
            ),
          )
        : LinearProgressIndicator();
  }

  void getProfile() async {
    await googleSignIn.signInSilently();
    account = googleSignIn.currentUser;
    auth = await account.authentication;
    setState(() {
      gotProfile = true;
    });
  }
}
