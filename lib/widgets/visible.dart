import 'package:flutter/material.dart';

class Visible extends StatefulWidget {
  const Visible({
    @required this.child,
    this.visible = false,
    this.animation = false,
  });

  final bool visible;
  final bool animation;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _VisibleState();
}

class _VisibleState extends State<Visible> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 360),
      vsync: this,
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        curve: Curves.fastOutSlowIn,
        opacity: widget.visible ? 1.0 : 0.6,
        duration: Duration(milliseconds: 500),
        child: widget.visible
          ? widget.child
          : widget.animation ? SizedBox(width: 0.0, height: 0.0) : Container(),
      ),
    );
  }
}

