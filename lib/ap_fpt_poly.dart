import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'app_model.dart';
import 'routes/auth.dart';
import 'routes/main.dart';
import 'routes/splash.dart';

class ApFptPoly extends StatelessWidget {
  Widget _buildWebView(BuildContext context) {
    final cookieHandler = AppModel.of(context).cookieHandler;
    final cookie = cookieHandler.readCookies("http://ap.poly.edu.vn");

    return WebviewScaffold(
      appBar: AppBar(title: Text("Tin tức")),
      url: "http://ap.poly.edu.vn/news/",
      withJavascript: true,
      headers: {'Cookie': cookie},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AP FPT Poly',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        primaryColorDark: Colors.deepOrange,
        accentColor: Colors.deepOrange,
      ),
      home: SplashScreen(),
      routes: {
        '/auth': (_) => AuthScreen(),
        '/main': (_) => MainScreen(),
        '/news': (_) => _buildWebView(context),
      },
    );
  }
}
