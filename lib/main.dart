import 'package:flutter/material.dart';
import 'package:namesclash/name.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namesclash/profile.dart';
import 'package:namesclash/splashscreen.dart';
import 'package:namesclash/signin.dart';

void main() {
  runApp(NameClash());
}

final Color bg = Color(0xff242C3D);
final Color bg2 = Color(0xFF3C4455);
final Color pc2 = Color(0xFFFF5858);
final Color pc = Color(0xffFC4C4C);

class NameClash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NamesClash",
      //home: SplashScreen(),
      routes: {
        '/': (_) => SplashScreen(),
        '/MySignInPage': (_) => MySignInPage(),
        //'/name': (_) => NamePage(),
        '/profile': (_) => ProfileScreen(),
      },
    );
  }
}
