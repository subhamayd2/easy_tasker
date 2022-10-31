import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final bool active;
  final Function onChange;

  ToggleButton({
    @required this.text,
    @required this.active,
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: active ? Theme.of(context).accentColor : Colors.grey[700],
      ),
      child: Text(text),
    );
  }
}
