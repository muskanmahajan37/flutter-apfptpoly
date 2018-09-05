import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/logo.dart';


class SplashScreen extends StatelessWidget {
  static const Duration _kSplashTimeout = Duration(seconds: 1);

  void _countDown(BuildContext context) async {
    await Future.delayed(_kSplashTimeout);
    Navigator.of(context).pushReplacementNamed('/main');
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