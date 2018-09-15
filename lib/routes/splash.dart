import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_settings.dart';
import '../widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  static const Duration _kSplashTimeout = Duration(seconds: 1);

  void _countDown(BuildContext context) async {
    await Future.delayed(_kSplashTimeout);
    AppSettings prefs = await AppSettings.getInstance();
    Navigator.of(context).pushReplacementNamed(prefs.isSignedIn ? '/main' : '/auth');
  }

  @override
  Widget build(BuildContext context) {
    _countDown(context);

    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Logo(),
      ),
    );
  }
}
