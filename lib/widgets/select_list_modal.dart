import 'package:flutter/material.dart';

class SelectListModal extends StatelessWidget {
  final List<String> items;
  final int selected;
  final Function onItemTap;

  const SelectListModal({this.items, this.selected, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];

          return Container(
            child: FlatButton(
              padding: EdgeInsets.all(16.0),
              child: Text(
                item,
                style: TextStyle(
                  color: index == selected ? Colors.deepOrange : Colors.black54,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(index == 0 ? 12.0 : 0.0),
                ),
              ),
              onPressed: () => onItemTap(index),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
          );
        },
      ),
    );
  }
}
