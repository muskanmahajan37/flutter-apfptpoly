import 'package:flutter/material.dart';

class Visible extends StatefulWidget {
  const Visible({
    @required this.child,
    this.visible = false,
  });

  final bool visible;
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
      child: widget.visible
        ? widget.child
        : SizedBox(width: 0.0, height: 0.0),
    );
  }
}

