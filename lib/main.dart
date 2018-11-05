import 'package:apfptpoly/screens/auth/auth.dart';
import 'package:apfptpoly/screens/splash/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(ApFptPoly());

class ApFptPoly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AP FPT Poly",
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: Splash(),
      routes: {
        "/auth": (context) => Auth(),
      },
    );
  }
}
