import 'package:apfptpoly/utils/cookie_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'routes/auth.dart';
import 'routes/main.dart';
import 'routes/splash.dart';

void main() => runApp(new ApFptPoly());

class ApFptPoly extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final CookieHandler cookieHandler = new CookieHandler();
    cookieHandler.setupStorage();

    return new MaterialApp(
      title: 'AP FPT Poly',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        primaryColorDark: Colors.deepOrange,
        //primaryColorDark: Colors.deepOrange[800],
        accentColor: Colors.deepOrange,
      ),
      home: SplashScreen(),
      routes: {
        '/auth': (_) => AuthScreen(),
        '/main': (_) => MainScreen(),
        '/news': (_) => WebviewScaffold(
              appBar: AppBar(
                title: Text("Tin tức"),
              ),
              headers: {
                'Cookie': cookieHandler.readCookies("http://ap.poly.edu.vn")
              },
              url: "http://ap.poly.edu.vn/news/",
              withJavascript: true,
            )
      },
    );
  }
}
