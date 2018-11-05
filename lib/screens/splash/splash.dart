import 'package:apfptpoly/widgets/logo.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  void _navigate(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacementNamed("/auth");
  }

  @override
  Widget build(BuildContext context) {
    // Navigate to the next screen
    _navigate(context);

    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(child: Logo()),
    );
  }
}
