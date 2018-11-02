import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({ this.loading = false });

  final bool loading;

  @override
  State<StatefulWidget> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  static const _kTag = "hero-logo";

  AnimationController controller;
  Animation<double> rippleAnimation;
  Animation<double> opacityAnimation;

  @override
  void didUpdateWidget(Logo oldWidget) {
    if (widget.loading) {
      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1, milliseconds: 400),
      );

      final curvedAnimation =
          CurvedAnimation(parent: controller, curve: Curves.ease);

      rippleAnimation =
          Tween(begin: 200.0, end: 260.0).animate(curvedAnimation);
      opacityAnimation = Tween(begin: 0.8, end: 0.0).animate(curvedAnimation);

      controller
        ..addListener(() => setState(() {}))
        ..repeat();
    } else {
      controller?.dispose();
    }
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _kTag,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: rippleAnimation?.value ?? 200.0,
            height: rippleAnimation?.value ?? 200.0,
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: Colors.white.withOpacity(opacityAnimation?.value ?? 0.0),
            ),
          ),
          Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(12.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
              shadows: kElevationToShadow[1],
            ),
            child: Image.asset("assets/images/logo.png"),
          ),
        ],
      ),
    );
  }
}