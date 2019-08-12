import 'package:flutter/material.dart';

class TerminalListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final Color color;
  final Color selectedBackgroundColor;
  final Color backgroundColor;
  final Function onPressed;

  const TerminalListTile(
      {Key key,
      @required this.title,
      @required this.icon,
      this.selected,
      this.selectedColor,
      this.color,
      this.backgroundColor,
      this.selectedBackgroundColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color:
            this.selected ? this.selectedBackgroundColor : this.backgroundColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: this.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              _buildIcon(),
              SizedBox(
                width: 8,
              ),
              Text(
                this.title,
                style: TextStyle(
                    color: this.selected ? this.selectedColor : this.color),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (this.icon != null) {
      return Icon(
        this.icon,
        color: this.selected ? this.selectedColor : this.color,
      );
    }
    return null;
  }
}
