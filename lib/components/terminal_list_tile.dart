import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TerminalListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final Color color;
  final Color selectedBackgroundColor;
  final Color backgroundColor;
  final Function onPressed;
  final Function onRemovePress;

  const TerminalListTile(
      {Key key,
      @required this.title,
      @required this.icon,
      this.selected,
      this.selectedColor,
      this.color,
      this.backgroundColor,
      this.selectedBackgroundColor,
      this.onPressed,
      this.onRemovePress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TerminalListTileState();
}

class _TerminalListTileState extends State<TerminalListTile> {
  bool _showDeleteBtn = false;
  double _removeBtnOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: widget.selected
            ? widget.selectedBackgroundColor
            : widget.backgroundColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: _handlePress,
        onLongPress: _handleLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: <Widget>[
                    _buildIcon(),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.title,
                    ),
                  ],
                ),
              ),
              _buildRemoveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.icon != null) {
      return Icon(
        widget.icon,
        color: widget.selected ? widget.selectedColor : widget.color,
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildRemoveButton() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 100),
      child: IconButton(
          icon: Icon(Icons.delete),
          padding: EdgeInsets.all(0),
          onPressed: _removeBtnOpacity == 1 ? widget.onRemovePress : null),
      opacity: _removeBtnOpacity,
    );
  }

  void _handleLongPress() {
    _toggleOpacity();
  }

  void _handlePress() {
    if (_removeBtnOpacity == 1) {
      _toggleOpacity();
    } else {
      widget.onPressed();
    }
  }

  void _toggleOpacity() {
    setState(() {
      _removeBtnOpacity = _removeBtnOpacity == 0 ? 1 : 0;
    });
  }
}
