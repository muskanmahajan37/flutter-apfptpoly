import 'package:flutter/material.dart';
import 'routes/splash.dart';
import 'routes/auth.dart';
import 'routes/main.dart';

void main() => runApp(new ApFptPoly());

class ApFptPoly extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AP FPT Poly',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        primaryColorDark: Colors.deepOrange,
        //primaryColorDark: Colors.deepOrange[800],
        accentColor: Colors.deepOrange
      ),
      home: SplashScreen(),
      routes: {
        '/auth': (_) => ChooseCampusScreen.AuthScreen(),
        '/main': (_) => MainScreen()
      }
    );
  }
}