import 'dart:async';

import 'package:apfptpoly/configs.dart';
import 'package:flutter/material.dart';

import '../app_model.dart';
import '../utils/app_settings.dart';
import '../widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _countDown();
  }

  void _countDown() async {
    await Future.delayed(kSplashTimeout);

    AppSettings appSettings = AppModel.of(context).appSettings;

    String nextRoute = appSettings.isSignedIn ? '/main' : '/auth';
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Logo(),
      ),
    );
  }
}
