import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({this.loading = false});

  final bool loading;

  @override
  State<StatefulWidget> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  static const _kTag = 'hero-logo';
  static const _kMaxRippleSize = 260.0;
  static const _kMinRippleSize = 200.0;
  static const _kRipplePadding = (_kMaxRippleSize - _kMinRippleSize) / 2;
  static const _kRippleAnimationTime = 1000;
  static const _kSizeAnimationTime = 500;
  static const _kAnimationTime = _kRippleAnimationTime + _kSizeAnimationTime;

  AnimationController rippleController;
  AnimationController sizeController;
  CurvedAnimation curveAnimation;
  Animation<Size> rippleSizeAnimation;
  Animation<Size> logoSizeAnimation;
  Animation<Color> colorAnimation;

  Timer timer;

  @override
  void initState() {
    _initAnimations();

    super.initState();
  }

  @override
  void dispose() {
    rippleController?.dispose();
    sizeController?.dispose();
    timer?.cancel();

    super.dispose();
  }

  void _initAnimations() {
    final rippleSizeTween = new SizeTween(
        begin: Size.square(_kMinRippleSize),
        end: Size.square(_kMaxRippleSize));

    final logoSizeTween = new SizeTween(
        begin: Size.square(_kMinRippleSize),
        end: Size.square(_kMinRippleSize + _kRipplePadding / 2));

    final colorTween = new ColorTween(
        begin: Colors.white,
        end: Colors.white.withOpacity(0.0));

    rippleController = new AnimationController(
        duration: Duration(milliseconds: _kRippleAnimationTime),
        vsync: this);

    sizeController = new AnimationController(
        duration: Duration(milliseconds: _kSizeAnimationTime),
        vsync: this);

    curveAnimation = new CurvedAnimation(
        parent: rippleController,
        curve: Curves.ease);

    rippleSizeAnimation = rippleSizeTween.animate(curveAnimation);
    logoSizeAnimation = logoSizeTween.animate(sizeController);
    colorAnimation = colorTween.animate(curveAnimation);

    // call setState() for each animation frame to update the view
    curveAnimation.addListener(() => setState(() {}));
    logoSizeAnimation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading && (timer == null || !timer.isActive)) {
      timer = new Timer.periodic(
          Duration(milliseconds: _kAnimationTime),
          (Timer t) {
        sizeController.forward();

        Timer(Duration(milliseconds: 300), () {
          rippleController.forward(from: 0.0);
        });

        Timer(Duration(milliseconds: _kSizeAnimationTime), () {
          sizeController.reverse();
        });
      });
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: _kTag,
            child: Container(
              width: _kMaxRippleSize,
              height: _kMaxRippleSize,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: rippleSizeAnimation.value.width,
                    height: rippleSizeAnimation.value.height,
                    decoration: BoxDecoration(
                        color: colorAnimation.value, shape: BoxShape.circle),
                  ),
                  Container(
                    width: logoSizeAnimation.value.width,
                    height: logoSizeAnimation.value.height,
                    padding: EdgeInsets.all(16.0),
                    child: Image.asset('assets/images/logo.png'),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[2]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          widget.loading
              ? Material(
                  color: Colors.transparent,
                  child: Text(
                    "Đăng nhập...",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                )
              : SizedBox(width: 0.0, height: 0.0),
        ],
      ),
    );
  }
}
