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
  Widget _buildChildWidget() {
    if (widget.animation) {
      return widget.visible ? widget.child : SizedBox(width: 0.0, height: 0.0);
    } else {
      return IgnorePointer(
        ignoring: !widget.visible,
        child: Opacity(
          opacity: widget.visible ? 1.0 : 0.0,
          child: widget.child,
        ),
      );
    }
  }

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
        child: _buildChildWidget(),
      ),
    );
  }
}
